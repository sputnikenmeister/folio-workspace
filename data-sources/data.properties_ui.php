<?php

require_once(EXTENSIONS . '/remote_datasource/data-sources/datasource.remote.php');

class datasourceproperties_ui extends RemoteDatasource {

    public $dsParamROOTELEMENT = 'properties-ui';
    public $dsParamURL = '{$workspace}/assets/src/sass/variables.json';
    public $dsParamFORMAT = 'json';
    public $dsParamXPATH = '/data/*';
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
            'name' => 'Properties/UI',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://localhost/projects/folio-sym',
                'email' => 'portfolio@canillas.name'),
            'version' => 'Symphony 2.7.6',
            'release-date' => '2018-06-19T12:25:04+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }

}