<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourceall_bundles extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'all-bundles';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'keywords'
        );
    public $dsParamSORT = 'completed';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '5' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'completed',
        'keywords'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'keywords' => array(
            'section_id' => '2',
            'field_id' => '46',
            'elements' => array(
                'name'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'All Bundles',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.0',
            'release-date' => '2014-09-28T15:47:03+00:00'
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