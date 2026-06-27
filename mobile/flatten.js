const fs = require('fs');
const path = require('path');

function flattenObject(ob) {
    var toReturn = {};
    for (var i in ob) {
        if (!ob.hasOwnProperty(i)) continue;
        if ((typeof ob[i]) == 'object' && ob[i] !== null) {
            var flatObject = flattenObject(ob[i]);
            for (var x in flatObject) {
                if (!flatObject.hasOwnProperty(x)) continue;
                toReturn[i + '.' + x] = flatObject[x];
            }
        } else {
            toReturn[i] = ob[i];
        }
    }
    return toReturn;
}

const dir = '/Users/os2026/Downloads/Reservatior/mobile/assets/translations';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.json'));

for (const file of files) {
    const filePath = path.join(dir, file);
    try {
        const content = fs.readFileSync(filePath, 'utf8');
        const obj = JSON.parse(content);
        const flattened = flattenObject(obj);
        fs.writeFileSync(filePath, JSON.stringify(flattened, null, 2));
        console.log(`Flattened ${file}`);
    } catch (e) {
        console.error(`Failed to flatten ${file}: ${e}`);
    }
}
