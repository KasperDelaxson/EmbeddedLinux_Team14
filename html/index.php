<!DOCTYPE html>
<html>
<head>
    <title>EMLI Log History</title>
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
    <h1>EMLI Log History</h1>
    <table>
        <tr>
            <th>Time</th>
            <th>Response</th>
            <th>Topic</th>
            <th>Value</th>
        </tr>
        <?php
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);
        
	// Include InfluxDBConnection.php
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

        // Number of records per page
        $recordsPerPage = 100;
	
	// Current page number
        $currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

        // Calculate the offset
        $offset = ($currentPage - 1) * $recordsPerPage;
	
	//Get the total number of records
        $totalRecords = count($values);

        // Calculate the total number of pages
        $totalPages = ceil($totalRecords / $recordsPerPage);

        // Get the records for the current page
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

    <!-- Pagination links -->
    <div class="pagination">
        <?php
        // Generate pagination links
        for ($i = 1; $i <= $totalPages; $i++) {
            echo '<a href="?page=' . $i . '" ' . ($i == $currentPage ? 'class="active"' : '') . '>' . $i . '</a>';
        }
        ?>
    </div>
</body>
</html>
