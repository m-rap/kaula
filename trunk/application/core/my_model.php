<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Model extends CI_Model {
    
    private $tablename;
    
    public function __construct($tablename) {
        parent::__construct();
        $this->load->database();
        $this->tablename = $tablename;
    }
    
    public function select() {
        $this->db->select('*');
    }
    
    public function create($data) {
        $this->db->insert($this->tablename, $data);
        return $this->db->insert_id();
    }
    
    public function read($where = '', $where_escaped = '') {
        if ($where != '')
            $this->db->where($where);
        if ($where_escaped != '') {
            if (is_array($where_escaped))
                foreach ($where_escaped as $key => $val)
                    $this->db->where($key, $val, false);
            else $this->db->where($where_escaped, null, false);
        }
        return $this->db->get($this->tablename);
    }
    
    public function update($data, $where = '', $where_escaped = '') {
        if ($where != '')
            $this->db->where($where);
        if ($where_escaped != '') {
            if (is_array($where_escaped))
                foreach ($where_escaped as $key => $val)
                    $this->db->where($key, $val, false);
            else $this->db->where($where_escaped, null, false);
        }
        $this->db->update($this->tablename, $data);
    }
    
    public function delete($where = '', $where_escaped = '') {
        if ($where != '')
            $this->db->where($where);
        if ($where_escaped != '') {
            if (is_array($where_escaped))
                foreach ($where_escaped as $key => $val)
                    $this->db->where($key, $val, false);
            else $this->db->where($where_escaped, null, false);
        }
        $this->db->delete($this->tablename);
    }
}