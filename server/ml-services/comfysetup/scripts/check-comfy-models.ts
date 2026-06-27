
async function main() {
    try {
        const res = await fetch('http://127.0.0.1:8188/object_info');
        const data = await res.json();

        if (data.ControlNetLoader) {
            console.log('ControlNet Models:', data.ControlNetLoader.input.required.control_net_name[0]);
        } else {
            console.log('ControlNetLoader node not found!');
        }

        if (data.CheckpointLoaderSimple) {
            console.log('Checkpoints:', data.CheckpointLoaderSimple.input.required.ckpt_name[0]);
        }
    } catch (e) {
        console.error(e);
    }
}

main();
