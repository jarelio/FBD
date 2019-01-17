
package model.bean;

import java.sql.Time;

/**
 *
 * @author Jarelio Filho
 */
public class Faixa {
    private int numero_faixa;
    private int cod_album;
    private int id_tipo_comp;
    private Time tempo_exec;
    private String tipo_grav;
    private String descricao;
    
    public Faixa(){
        
    }

    public Faixa(int numero_faixa, int cod_album, String tipo_grav, String descricao, Time tempo_exec, int id_tipo_comp) {
        this.numero_faixa = numero_faixa;
        this.cod_album = cod_album;
        this.id_tipo_comp = id_tipo_comp;
        this.tempo_exec = tempo_exec;
        this.tipo_grav = tipo_grav;
        this.descricao = descricao;
    }
    
    public int getNumFaixa(){
        return numero_faixa;
    }
    
    public void setNumFaixa(int num_faixa){
         this.numero_faixa = num_faixa;
    }
    
    public int getCodAlbum(){
        return cod_album;
    }
    
    public void setCodAlbum(int cod_alb){
        this.cod_album = cod_alb;
    }
    
    public int getIdTipoComp(){
        return id_tipo_comp;
    }
    
    public void setIdTipoComp(int id_tipo){
        this.id_tipo_comp = id_tipo;
    }
    
    public Time getTempoExec(){
        return tempo_exec;
    }
        
    public void setTempoExec(Time tempo){
        this.tempo_exec = tempo;
    }
    
    public String getTipoGrav(){
        return tipo_grav;
    }
    
    public void setTipoGrav(String tipo_g){
        this.tipo_grav = tipo_g;
    }
    
    public String getDescricao(){
        return descricao;
    }
    
    public void setDescricao(String desc){
        this.descricao = desc;
    }
}
