<?php

// Include the InfluxDB credentials file
require_once 'credential.php';

// InfluxDB configuration
$host = 'localhost';
$port = 8086;
$database = 'plant_watering_system';
$measurement = 'HealthLogging';

// API endpoint for querying data
$url = "http://{$host}:{$port}/query";

// Query to retrieve data
$query = "SELECT * FROM {$measurement}";

// Build the request payload
$data = [
    'db' => $database,
    'q' => $query
];

// Initialize cURL
$curl = curl_init($url);

// Set cURL options
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
curl_setopt($curl, CURLOPT_HTTPHEADER, [
    'Content-Type: application/x-www-form-urlencoded',
    "Authorization: Basic " . base64_encode("$username:$password")
]);

// Execute the cURL request
$response = curl_exec($curl);

// Check for errors
if ($response === false) {
    die(curl_error($curl));
}

// Close cURL
curl_close($curl);

// Process the response
$data = json_decode($response, true);
if ($data === null) {
    die('Error decoding JSON response');
}

// Extract the result from the response
$result = $data['results'][0];

// Extract the data points from the result
$series = $result['series'][0];
$columns = $series['columns'];
$values = $series['values'];

// Process and display the data
foreach ($values as $value) {
    $dataPoint = array_combine($columns, $value);
    // Process the data point as needed
}

// Output the response to the browser
return $response;

?>
