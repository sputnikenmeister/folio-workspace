<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourceget_bundle extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'get-bundle';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '1';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'yes';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'images',
        'keywords'
        );
    public $dsParamSORT = 'completed';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$ds-map-bundles-by-handle.system-id:$bundles:0}',
        '5' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'completed',
        'description: formatted',
        'images',
        'attributes'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'images' => array(
            'section_id' => '5',
            'field_id' => '45',
            'elements' => array(
                'published',
                'file',
                'description: formatted',
                'attributes'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-map-bundles-by-handle.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Get Bundle',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.1',
            'release-date' => '2014-10-30T14:26:47+00:00'
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