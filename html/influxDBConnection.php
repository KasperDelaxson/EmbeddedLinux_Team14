<?php
require_once 'credential.php';

$host = 'localhost';
$port = 8086;
$database = 'plant_watering_system';
$measurement = 'HealthLogging';

$url = "http://{$host}:{$port}/query";

$query = "SELECT * FROM {$measurement}";

$data = [
    'db' => $database,
    'q' => $query
];

$curl = curl_init($url);

curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
curl_setopt($curl, CURLOPT_HTTPHEADER, [
    'Content-Type: application/x-www-form-urlencoded',
    "Authorization: Basic " . base64_encode("$username:$password")
]);

$response = curl_exec($curl);

if ($response === false) {
    die(curl_error($curl));
}

curl_close($curl);

$data = json_decode($response, true);
if ($data === null) {
    die('Error decoding JSON response');
}

$result = $data['results'][0];

$series = $result['series'][0];
$columns = $series['columns'];
$values = $series['values'];

foreach ($values as $value) {
    $dataPoint = array_combine($columns, $value);
}

return $response;
