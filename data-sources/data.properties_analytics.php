<?php

require_once(EXTENSIONS . '/remote_datasource/data-sources/datasource.remote.php');

class datasourceproperties_analytics extends RemoteDatasource {

    public $dsParamROOTELEMENT = 'properties-analytics';
    public $dsParamURL = '{$workspace}/properties/ga.json';
    public $dsParamFORMAT = 'json';
    public $dsParamXPATH = '*';
    public $dsParamCACHE = 0;
    public $dsParamTIMEOUT = 6;

    public function __construct($env=NULL, $process_params=true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Properties/Analytics',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://localhost/projects/folio-sym',
                'email' => 'nobody@localhost'),
            'version' => 'Symphony 2.7.6',
            'release-date' => '2018-05-25T18:18:56+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }

}
