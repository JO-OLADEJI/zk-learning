const fs = require('fs');

const FILE_PATH = 'witness.wtns';

const raw = fs.readFileSync(FILE_PATH);

let data = new Uint8Array(raw);
console.dir(data, { 'maxArrayLength': null });

// EXPLOIT: alter witness
// fs.writeFileSync('exploit_witness.wtns', data);
