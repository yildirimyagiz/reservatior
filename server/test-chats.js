const { Client, LocalAuth } = require('whatsapp-web.js');

const client = new Client({
    authStrategy: new LocalAuth()
});

client.on('ready', async () => {
    console.log('Client is ready!');
    const chats = await client.getChats();
    console.log("CHATS: ");
    chats.forEach(c => console.log(c.name));
    process.exit(0);
});

client.initialize();
