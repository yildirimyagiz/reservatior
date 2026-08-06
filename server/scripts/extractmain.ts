import whatsappPkg from "whatsapp-web.js";
const { Client, LocalAuth } = whatsappPkg;

import qrcode from "qrcode-terminal";
import fs from "fs";
import path from "path";

const includeKeywords = [
    "gayrimenkul",
    "emlak",
    "satılık",
    "kiralık",
    "portföy",
    "villa",
    "residence",
    "arsa",
    "investment",
    "developer",
    "estate",
];

const excludeKeywords = [
    "genel",
    "midpoint",
    "hacking",
    "medrese",
];

const client = new Client({
    authStrategy: new LocalAuth({
        clientId: "reservatior-whatsapp",
        dataPath: "./.wwebjs_auth",
    }),

    puppeteer: {
        headless: false,
        executablePath: process.env.PUPPETEER_EXECUTABLE_PATH,
        args: [
            "--no-sandbox",
            "--disable-setuid-sandbox",
            "--disable-dev-shm-usage",
            "--disable-gpu",
            "--no-first-run",
            "--no-default-browser-check",
        ],
    },

    webVersionCache: {
        type: "none",
    },
});

client.on("qr", qr => {
    qrcode.generate(qr, { small: true });
});

client.on("loading_screen", (percent, msg) => {
    console.log(percent + "%", msg);
});

client.on("change_state", state => {
    console.log("STATE:", state);
});

client.on("auth_failure", err => {
    console.log("AUTH FAILURE", err);
});

client.on("disconnected", reason => {
    console.log("DISCONNECTED:", reason);
});

client.on("ready", async () => {

    console.log("WhatsApp hazır.");

    const chats = await client.getChats();

    const groups = chats.filter(chat => {
        if (!chat.isGroup) return false;

        const name = chat.name.toLowerCase();

        const ok =
            includeKeywords.some(k => name.includes(k)) &&
            !excludeKeywords.some(k => name.includes(k));

        return ok;
    });

    console.log(`${groups.length} grup bulundu.`);

    const output = path.join(process.cwd(), "data", "all_members.csv");

    fs.mkdirSync(path.dirname(output), {
        recursive: true,
    });

    fs.writeFileSync(
        output,
        "Grup,Telefon\n",
        "utf8",
    );

    const unique = new Set<string>();

    for (const group of groups) {

        console.log(group.name);

        const chat = await client.getChatById(group.id._serialized);

        if (!("participants" in chat))
            continue;

        for (const participant of chat.participants) {

            const id =
                participant.id.user ??
                participant.id._serialized.split("@")[0];

            if (!id)
                continue;

            if (unique.has(id))
                continue;

            unique.add(id);

            fs.appendFileSync(
                output,
                `"${group.name}","${id}"\n`,
            );
        }

        await Bun.sleep(500);
    }

    console.log("Toplam:", unique.size);

    process.exit(0);
});

client.initialize();