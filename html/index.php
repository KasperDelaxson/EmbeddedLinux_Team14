<!DOCTYPE html>
<html>
<head>
    <title>Plant Watering System</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

 h1 {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: #fff;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
            max-width: 800px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        @media (max-width: 600px) {
            table {
                width: 100%;
            }
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            color: #333;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color 0.3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #333;
            color: #fff;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <h1>Plant Watering System - Health Monitoring</h1>
    <table>
        <tr>
            <th>Time</th>
            <th>Device</th>
            <th>Topic</th>
            <th>Log</th>
        </tr>
        <?php
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);
        
        require_once 'influxDBConnection.php';

	foreach ($values as $key => $value) {
    		$values[$key][0] = to_date_unix($value[0]);
	}

	function compareDate($a, $b)
	{
    	if ($a == $b) {
        	return 0;
    		}
    		return ($a < $b) ? 1 : -1;
	}

	function to_date_unix($time){
		return DateTime::createFromFormat("Y-m-d\TH:i:s", substr($time, 0, 19));	
	}

	function toFormat($date){
		return $date->format("Y-m-d H:i:s");
	}

	usort($values, "compareDate");

        $recordsPerPage = 100;
	
        $currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

        $offset = ($currentPage - 1) * $recordsPerPage;
	
        $totalRecords = count($values);

        $totalPages = ceil($totalRecords / $recordsPerPage);

        $currentPageRecords = array_slice($values, $offset, $recordsPerPage);
	foreach ($currentPageRecords as $data) {
            $time = toFormat($data[0]);
            $response = $data[1];
            $topic = $data[2];
            $value = $data[3];

            echo '<tr>';
            echo '    <td>' . $time . '</td>';
            echo '    <td>' . $response . '</td>';
            echo '    <td>' . $topic . '</td>';
            echo '    <td>' . $value . '</td>';
            echo '</tr>';
        }
        ?>
    </table>

    <div class="pagination">
        <?php
        for ($i = 1; $i <= $totalPages; $i++) {
            echo '<a href="?page=' . $i . '" ' . ($i == $currentPage ? 'class="active"' : '') . '>' . $i . '</a>';
        }
        ?>
    </div>
</body>
</html>
