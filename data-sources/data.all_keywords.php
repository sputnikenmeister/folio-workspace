<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourceall_keywords extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'all-keywords';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '{$url-pagesize:99}';
    public $dsParamSTARTPAGE = '{$url-pagenum:1}';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'type'
        );
    public $dsParamSORT = 'system:id';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
    public $dsParamCACHE = '';

    public $dsParamFILTERS = array(
        'system:id' => '{$ds-all-bundles.keywords:$ds-bundles-by-handle.keywords}',
        '32' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'type',
        'attributes',
        'uid'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'type' => array(
            'section_id' => '7',
            'field_id' => '28',
            'elements' => array(
                'name'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-all-bundles.keywords', '$ds-bundles-by-handle.keywords');
    }

    public function about()
    {
        return array(
            'name' => 'All Keywords',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.1',
            'release-date' => '2014-10-27T12:58:29+00:00'
        );
    }

    public function getSource()
    {
        return '2';
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