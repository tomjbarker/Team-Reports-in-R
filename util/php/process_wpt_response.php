<?php

require("wpt_credentials_urls.php");
require("fileio.php");


function readCSVurls($csvFiles, $file){
	print $csvFiles . "\n";
	if (file_exists($csvFiles) && is_readable ($csvFiles)) {
		$fh = fopen($csvFiles, "r") or die("\n can't open file $csvFiles");
		while (!feof($fh)) {
			$line = fgets($fh);
			$tailEntry = file_get_contents(trim($line));
			if($tailEntry){
				$xml = new SimpleXMLElement($tailEntry);
				//print_r($xml);
				if($xml->data->statusText != "Ok"){
					$url = $xml->data->run->firstView->results->URL;
					$date = $xml->data->completed;
					$loadtime = $xml->data->run->firstView->results->loadTime;
					$bytes = $xml->data->run->firstView->results->bytesInDoc;
					$httprequests = $xml->data->run->firstView->results->requests;
					$newline = "$url, $date, $loadtime, $bytes, $httprequests";
					if(!file_exists($file)){
						formatWPOLog($file);
					}
					appendToFile($newline, $file);	
				}else{
					die("report not ready at webpagetest yet.\n");
				}
			}
		}
	}
	fclose($fh);	
}

function formatWPOLog($file){
	$headerline = "url, date, loadtime, bytes, httprequests";
	appendToFile($headerline, $file);
}


readCSVurls($csvFiles, $wpologfile);

?>