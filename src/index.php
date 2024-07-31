<?php

    $dbConnStatus=include('api/server-config.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enigma</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/scripts.js"></script>
</head>

<body>
    <div id="header">

    </div>
    <div id="main-container">

        <div class="task-container">
        
            <div class="left-icon">
                <img id="clock-icon" src="assets/images/clock.svg" alt="icon">
            </div>
        
            <div class="task-heading-container">
        
                <h2 id="task-heading-text">Task Heading</h2>
        
                <h2 id="task-points">Associated points</h2>
        
            </div>

            <div class="action-state">
                <button class="action-button">Complete</button>
            </div>

        </div>
    
        <div id="progress-container">

            <div id="progress-bar"></div>


            <div id="design-overlay"></div>

        </div>

    </div>
</body>

</html>