/* YGOPro Percy Script Moderniser
 * by AlphaKretin, November 2018
 * Applies modern script standard updates to YGOPro card script files.
 * For usage and notes, see the readme.
 */

// replaces the "cID" and card's ID with the s,id from the new GetID() function
async function updateGetID(file, fileName) {
    const EXTRACT_S = /c\d+/g; // the "s", or cID.
    const GET_ID_LOCATION = /(\r|\n|\r\n)function s\.initial_effect\(c\)/; // the location to insert the GetID() function, before the initial effect declaration
    const GET_ID = /GetID\(\)/; // checks if script already has a GetID() call
    const sResult = EXTRACT_S.exec(fileName);
    if (!sResult) {
        // e.g. utility, constant, do not modify - though those shouldn't be run through this anyway
        return file;
    }
    const s = sResult[0];
    const sReg = new RegExp(s, "g");
    const id = s.substr(1); // the "s" is the letter c followed by the ID
    const idReg = new RegExp(id, "g");
    file = file.replace(sReg, "s");
    file = file.replace(idReg, "id");
    const idNum = parseInt(id);
    if (!isNaN(idNum)) {
        const idPlusOne = (idNum + 1).toString(); // e.g. multiple HOPT or token
        const iPOReg = new RegExp(idPlusOne, "g");
        const idPlusHundred = (idNum + 100).toString(); // e.g. beta HOPT
        const iPHReg = new RegExp(idPlusHundred, "g");
        file = file.replace(iPOReg, "id+1");
        file = file.replace(iPHReg, "id+100");
    }
    const getIDResult = GET_ID_LOCATION.exec(file);
    if (getIDResult === null && !GET_ID.test(file)) {
        console.log("Failed to find location to insert GetID() in " + fileName + "! May need to be inserted manually!");
    } else {
        const initialEffect = getIDResult[0]; // whole match needs to be reinserted with the additions
        const newLine = getIDResult[1]; // capture group is newline, keep consistent with source when inserting
        if (!GET_ID.test(file)) {
            file = file.replace(GET_ID_LOCATION, newLine + "local s,id=GetID()" + initialEffect);
        }
    }
    return file;
}

const CONST_MAP = {
    "0x1fe0000": "RESETS_STANDARD",
    "0x1ff0000": "RESETS_STANDARD_DISABLE",
    "0x47e0000": "RESETS_REDIRECT",
    "0x17a0000": "RESETS_STANDARD_EXC_GRAVE",
    "0x17e0000": "RESETS_CANNOT_ACT",
    "0x4011": "TYPES_TOKEN",
    "59822133": "CARD_BLUEEYES_SPIRIT",
    "29724053": "CARD_SUMMON_GATE",
    "24094653": "CARD_POLYMERIZATION",
    "47355498": "CARD_NECROVALLEY",
    "56433456": "CARD_SANCTUARY_SKY",
    "22702055": "CARD_UMI",
    "46986414": "CARD_DARK_MAGICIAN",
    "38033121": "CARD_DARK_MAGICIAN_GIRL",
    "89631139": "CARD_BLUEEYES_W_DRAGON",
    "93717133": "CARD_GALAXYEYES_P_DRAGON",
    "70095154": "CARD_CYBER_DRAGON",
    "74677422": "CARD_REDEYES_B_DRAGON",
    "72283691": "CARD_STROMBERG",
    "89943723": "CARD_NEOS",
    "90351981": "CARD_ORPHEGEL_BABEL",
    "70781052": "CARD_SUMMONED_SKULL",
    "76812113": "CARD_HARPIE_LADY",
    "12206212": "CARD_HARPIE_LADY_SISTERS",
    "1295111": "CARD_SALAMANGREAT_SANCTUARY",
    "8802510": "CARD_PSYFRAME_LAMBDA",
    "49036338": "CARD_PSYFRAME_DRIVER",
    "46241344": "CARD_FIRE_FIST_EAGLE",
    "80280737": "CARD_ASSAULT_MODE",
    "15610297": "CARD_VIJAM"
};

// updates new constants such as reset sums and common card IDs
async function updateConstants(file) {
    for (const key in CONST_MAP) {
        const reg = new RegExp(key, "g");
        file = file.replace(reg, CONST_MAP[key]);
    }
    return file;
}

const RegisterFlagRegex = i => new RegExp(":RegisterEffect\\((.+?),(?:false|true)," + i + "\\)", "g");

const REGISTER_FLAG_MAP = {
    1: "REGISTER_FLAG_DETACH_XMAT",
    2: "REGISTER_FLAG_CARDIAN",
    4: "REGISTER_FLAG_THUNDRA"
};

async function updateRegisterFlags(file) {
    for (const key in REGISTER_FLAG_MAP) {
        const reg = RegisterFlagRegex(key);
        file = file.replace(reg, ":RegisterEffect($1,false," + REGISTER_FLAG_MAP[key] + ")");
    }
    return file;
}

// updates new operators like Group metamethods and lua 5.3 bitwise operators
async function updateOperators(file) {
    const GET_COUNT = /([a-zA-Z0-9]+?):GetCount\(\)/g;
    const BIT_BAND = /bit\.band\((.+?),(.+?)\)/g;
    const BIT_BOR = /bit\.bor\((.+?),(.+?)\)/g;
    const BIT_BXOR = /bit\.bxor\((.+?),(.+?)\)/g;
    const BIT_LSHIFT = /bit\.lshift\((.+?),(.+?)\)/g;
    const BIT_RSHIFT = /bit\.rshift\((.+?),(.+?)\)/g;
    const BIT_NOT = /bit\.not\((.+?)\)/g; // apparently unused
    file = file.replace(GET_COUNT, "#$1");
    file = file.replace(BIT_BAND, "($1&$2)");
    file = file.replace(BIT_BOR, "($1|$2)");
    file = file.replace(BIT_BXOR, "($1~$2)");
    file = file.replace(BIT_LSHIFT, "($1<<$2)");
    file = file.replace(BIT_RSHIFT, "($1>>$2)");
    file = file.replace(BIT_NOT, "(~$1)");
    return file;
}

const fs = require("fs");

const IN_DIR = "./script/";
const OUT_DIR = "./newscript/";
const UPDATE_FUNCS = [updateGetID, updateConstants, updateOperators, updateRegisterFlags]; // order of ID/constants matters if updating a card with an ID that is a constant
function updateScript(fileName) {
    return new Promise((resolve, reject) => {
        fs.readFile(IN_DIR + fileName, "utf8", async (err, file) => {
            if (err) {
                return reject(err);
            }
            for (const func of UPDATE_FUNCS) {
                file = await func(file, fileName);
            }
            fs.writeFile(OUT_DIR + fileName, file, "utf8", e => {
                if (e) {
                    return reject(e);
                }
                resolve();
            });
        });
    });
}

fs.readdir(IN_DIR, (err, files) => {
    if (err) {
        console.error(err);
    } else {
        console.log("Starting script update!");
        let i = 0;
        const thresh = files.length / 2;
        let yet = false;
        const promises = [];
        for (const fileName of files) {
            //console.log("Updating " + fileName + "!"); // disabled to prevent slowdown with many files
            promises.push(
                updateScript(fileName).then(() => {
                    if (!yet) {
                        i++;
                        if (i++ > thresh) {
                            console.log("Halfway there!");
                            yet = true;
                        }
                    }
                })
            ); // don't await, handle multiple files at once
        }
        console.log("Started all updates!");
        Promise.all(promises).then(() => {
            console.log("Done!");
        });
    }
});
