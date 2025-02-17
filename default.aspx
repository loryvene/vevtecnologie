<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>
<html>
<head>
    <title>Contatore in Tempo Reale</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        #counter-container {
            text-align: center;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        #lblCounter {
            font-size: 48px;
            font-weight: bold;
            color: #333333;
        }

        .btn {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .btn:active {
            background-color: #003f7f;
        }
    </style>
    <script type="text/javascript">
        let intervalId = null;

        // Funzione per avviare il contatore
        function startCounter() {
            if (intervalId === null) {
                intervalId = setInterval(function () {
                    fetch('Default.aspx?getCounter=true') // Richiesta al server
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById('lblCounter').innerText = data;
                        });
                }, 1000);
            }
        }

        // Ferma il conteggio
        function stopCounter() {
            if (intervalId !== null) {
                clearInterval(intervalId);
                intervalId = null;
            }
        }

        // Azzera il contatore
        function resetCounter() {
            stopCounter();
            fetch('Default.aspx?resetCounter=true') // Richiesta per azzerare il contatore
                .then(response => response.text())
                .then(data => {
                    document.getElementById('lblCounter').innerText = data;
                });
        }

        // Riprende il conteggio da dove è stato fermato
        function resumeCounter() {
            startCounter(); // Riprende il conteggio senza azzerare
        }

        // Avvia il conteggio all'apertura della pagina
        window.onload = startCounter;
    </script>
</head>
<body>
    <div id="counter-container">
        <span id="lblCounter">0</span>
        <br />
        <button class="btn" onclick="stopCounter()">Ferma</button>
        <button class="btn" onclick="resetCounter()">Azzera</button>
        <button class="btn" onclick="resumeCounter()">Riprendi</button>
    </div>
</body>
</html>