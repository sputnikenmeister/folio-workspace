<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourcebundles_by_handle extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'bundles-by-handle';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '{$url-pagesize:99}';
    public $dsParamSTARTPAGE = '{$url-pagenum:1}';
    public $dsParamREDIRECTONEMPTY = 'yes';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'yes';
    public $dsParamREQUIREDPARAM = '$bundles';
    public $dsParamPARAMOUTPUT = array(
        'system:id',
        'keywords'
        );
    public $dsParamSORT = 'completed';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';
    public $dsParamCACHE = '0';

    public $dsParamFILTERS = array(
        '1' => '{$ds-bundles-by-id-to-handle.name:$bundles}',
        '5' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'completed',
        'description: formatted',
        'images',
        'attributes',
        'uid'
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
        $this->_dependencies = array('$ds-bundles-by-id-to-handle.name');
    }

    public function about()
    {
        return array(
            'name' => 'Bundles by handle',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.1',
            'release-date' => '2014-10-27T13:22:08+00:00'
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