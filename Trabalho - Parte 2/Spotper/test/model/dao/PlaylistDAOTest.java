/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import model.bean.Playlist;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

/**
 *
 * @author Jarelio Filho
 */
public class PlaylistDAOTest {
    
    public PlaylistDAOTest() {
    }

    @Test
    public void inserir() {
        Time tempo;
        String stringTempo = "00:00:00";
        tempo = Time.valueOf(stringTempo);
       
        Calendar cal = Calendar.getInstance();  
        Timestamp data = new java.sql.Timestamp(cal.getTimeInMillis());
        Playlist playlist = new Playlist(1,"Playlist 1",data,tempo);
        PlaylistDAO playlistdao = new PlaylistDAO();
        
        if(playlistdao.inserir(playlist)){
            System.out.println("Playlist inserida com sucesso!");
        }else{
            fail("Erro ao inserir Playlist!");
        }
    }
    
    @Test
    @Ignore
    public void listar(){
        
        PlaylistDAO playlist = new PlaylistDAO();
        List<Playlist> playlists;
        playlists = playlist.getPlaylists();
        
        for(Playlist p : playlists){
            System.out.print(p.getCodPlay() + " ");
            System.out.print(p.getNome() + " ");
            System.out.print(p.getDataCriacao()+ " ");
            System.out.println(p.getDuracaoExec());
        }
    }
    
}
