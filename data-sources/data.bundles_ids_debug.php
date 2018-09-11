<?php

class datasourcebundles_ids_debug extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'bundles-ids-debug';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamREQUIREDPARAM = '$url-force-debug:$ds-author-logged-in.id';
    public $dsParamNEGATEPARAM = '$url-force-nodebug';
    public $dsParamPARAMOUTPUT = array(
        'system:id'
        );
    public $dsParamSORT = 'completed';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '33' => '@debug-only',
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-author-logged-in.id');
    }

    public function about()
    {
        return array(
            'name' => 'Bundles/IDs/Debug',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://localhost/projects/folio-sym',
                'email' => 'portfolio@canillas.name'),
            'version' => 'Symphony 2.7.6',
            'release-date' => '2018-09-11T14:26:56+00:00'
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

        try {
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error',
                General::wrapInCDATA($e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile())
            ));
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