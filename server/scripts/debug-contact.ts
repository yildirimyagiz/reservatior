import { Client, LocalAuth } from 'whatsapp-web.js';

const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth'
    }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
});

client.on('ready', async () => {
    console.log('\n✅ WhatsApp hesabınıza bağlandı!\n');

    try {
        const chats = await client.getChats();
        const targetChat = chats.find(chat => chat.name.includes('Ticari | Dükkan'));

        if (!targetChat) {
            console.log("Chat not found");
            process.exit(1);
        }

        const messages = await targetChat.fetchMessages({ limit: 10 });
        for (const msg of messages) {
            console.log(`\n--- Message ---`);
            console.log(`msg.from: ${msg.from}`);
            console.log(`msg.author: ${msg.author}`);
            
            const contact = await msg.getContact();
            console.log(`contact.id:`, contact.id);
            console.log(`contact.number: ${contact.number}`);
            console.log(`contact.pushname: ${contact.pushname}`);
            console.log(`contact.name: ${contact.name}`);
        }
        
        process.exit(0);

    } catch (error) {
        console.error("Hata:", error);
        process.exit(1);
    }
});

client.initialize();
