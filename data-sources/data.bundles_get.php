<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourcebundles_get extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'bundles-get';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '1';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'system:id',
        'keywords'
        );
    public $dsParamSORT = 'completed';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$ds-bundles-map-by-handle.system-id:$bundles:0}',
        '5' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'display-name: formatted',
        'completed',
        'description: formatted',
        'attributes'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-bundles-map-by-handle.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Bundles Get',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://folio.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.1',
            'release-date' => '2014-11-27T10:24:45+00:00'
        );
    }

    public function getSource()
    {
        return '1';
    }

    public function allowEditorToParse()
    {
        return true;
    }

    public function execute(array &$param_pool = null)
    {
        $result = new XMLElement($this->dsParamROOTELEMENT);

        try{
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
            return $result;
        }

        if ($this->_force_empty_result) {
            $result = $this->emptyXMLSet();
        }

        if ($this->_negate_result) {
            $result = $this->negateXMLSet();
        }

        return $result;
    }
}
