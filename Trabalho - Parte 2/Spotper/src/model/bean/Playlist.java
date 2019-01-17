
package model.bean;

import java.sql.Timestamp;
import java.sql.Time;

/**
 *
 * @author Jarelio Filho
 */
public class Playlist {
    private int cod_play;
    private String nome;
    private Timestamp dt_criacao;
    private Time duracao_exec;

    public Playlist() {
    }

    public Playlist(int cod_play, String nome, Timestamp dt_criacao, Time duracao_exec) {
        this.cod_play = cod_play;
        this.nome = nome;
        this.dt_criacao = dt_criacao;
        this.duracao_exec = duracao_exec;
    }

    
    public int getCodPlay(){
        return cod_play;
    }
    
    public void setCodPlay(int cod_p){
         this.cod_play = cod_p;
    }
    
    public String getNome(){
        return nome;
    }
    
    public void setNome(String nom){
        this.nome = nom;
    }
    
    public Timestamp getDataCriacao(){
        return dt_criacao;
    }
    
    public void setDataCriacao(Timestamp data_c){
        this.dt_criacao = data_c;
    }
    
    public Time getDuracaoExec(){
        return duracao_exec;
    }
        
    public void setDuracaoExec(Time tempo){
        this.duracao_exec = tempo;
    }
    
}