<?php

require_once(EXTENSIONS . '/remote_datasource/data-sources/datasource.remote.php');

class datasourceproperties_ga extends RemoteDatasource {

    public $dsParamROOTELEMENT = 'properties-ga';
    public $dsParamURL = '{$workspace}/properties/ga.json';
    public $dsParamFORMAT = 'json';
    public $dsParamXPATH = '/data/tags';
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
            'name' => 'Properties/GA',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://localhost/projects/folio-sym',
                'email' => 'portfolio@canillas.name'),
            'version' => 'Symphony 2.7.6',
            'release-date' => '2018-09-11T10:47:46+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }

}