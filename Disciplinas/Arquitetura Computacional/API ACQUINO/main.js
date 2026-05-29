// importa os bibliotecas necessários
const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');

// constantes para configurações
const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;

// habilita ou desabilita a inserção de dados no banco de dados
const HABILITAR_OPERACAO_INSERIR = true;

// função para comunicação serial
const serial = async (
    // valoresSensorAnalogico,
    valoresSensorBloqueio,
) => {

    // conexão com o banco de dados MySQL
    let poolBancoDados = mysql.createPool(
        {
            host: '127.0.0.1',
            user: 'aluno',
            password: 'sptech',
            database: 'flow',
            port: 3306
        }
    ).promise();

    // lista as portas seriais disponíveis e procura pelo Arduino
    const portas = await serialport.SerialPort.list();
    // const portaArduino = portas.find((porta) => porta.vendorId == '1A86' && porta.productId == 7523);
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }

    // configura a porta serial com o baud rate especificado
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    // evento quando a porta serial é aberta
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    // processa os dados recebidos do Arduino
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        console.log(data);
        const valores = data.split(';');
        const sensorBloqueio = valores[0];

        // 0 = Alimenticio        // 3 = Vestuario 
        // 1 = Eletronicos        // 4 = Higiene
        // 2 = Utencilios         // 5 = Caixa

        let leituraSetores = [];

        for (let i = 0; i <= 5; i++) {
            let inserido;
            let dado = sensorBloqueio + Math.floor(Math.random() * 9)
            if (i == 0) {
                if (dado >= 1) {
                    inserido = 1;
                } else {
                    inserido = 0;
                }
                leituraSetores.push(inserido)
            } else if (i == 1) {
                if (dado >= 3) {
                    inserido = 1;
                } else {
                    inserido = 0;
                }
                leituraSetores.push(inserido)
            } else if (i == 2) {
                if (dado >= 5) {
                    inserido = 1;
                } else {
                    inserido = 0;
                }
                leituraSetores.push(inserido)
            } else if (i == 3) {
                if (dado >= 7) {
                    inserido = 1;
                } else {
                    inserido = 0;
                }
                leituraSetores.push(inserido)
            } else if (i == 4) {
                if (dado >= 9) {
                    inserido = 1;
                } else {
                    inserido = 0;
                }
                leituraSetores.push(inserido)
            }
        }

        valoresSensorBloqueio.push(sensorBloqueio);

        // insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {
            for (let i = 1; i <= leituraSetores.length; i++) {
                if (leituraSetores[i] == 1) {
                    await poolBancoDados.execute(
                        'INSERT INTO registroSensor (leitura, fkSensor) VALUES (?, ?)',
                        [leituraSetores[i], i]
                    );
                }
            }
        }

    });

    // evento para lidar com erros na comunicação serial
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

// função para criar e configurar o servidor web
const servidor = (
    // valoresSensorAnalogico,
    valoresSensorBloqueio
) => {
    const app = express();

    // configurações de requisição e resposta
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // inicia o servidor na porta especificada
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // define os endpoints da API para cada tipo de sensor
    // app.get('/sensores/analogico', (_, response) => {
    //     return response.json(valoresSensorAnalogico);
    // });
    app.get('/sensores/bloqueio', (_, response) => {
        return response.json(valoresSensorBloqueio);
    });
}

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    // arrays para armazenar os valores dos sensores
    // const valoresSensorAnalogico = [];
    const valoresSensorBloqueio = [];

    // inicia a comunicação serial
    await serial(
        // valoresSensorAnalogico,
        valoresSensorBloqueio
    );

    // inicia o servidor web
    servidor(
        // valoresSensorAnalogico,
        valoresSensorBloqueio
    );
})();
