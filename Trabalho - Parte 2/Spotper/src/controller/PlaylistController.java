/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.bean.Playlist;
import model.dao.PlaylistDAO;

/**
 *
 * @author Jarelio Filho
 */
public class PlaylistController {
    public List<Playlist> getPlaylists(){
        PlaylistDAO playlistDAO = new PlaylistDAO();
        List<Playlist> playlists;
        playlists = playlistDAO.getPlaylists();
        return playlists;
    }
    
    public boolean inserirPlaylist(Playlist playlist){
        PlaylistDAO playlistDAO = new PlaylistDAO();
        if(playlistDAO.inserir(playlist)){
            System.out.println("Playlist inserida com sucesso!");
            return true;
        }else{
            System.err.println("Falha ao inserir a playlist");
            return false;
        }
    }
    
    public boolean deletePlaylist(int cod_play){
        PlaylistDAO playlistDAO = new PlaylistDAO();
        if(playlistDAO.delete(cod_play)){
            System.out.println("Playlist deletada com sucesso!");
            return true; 
        }else{
            System.err.println("Falha ao deletar a playlist");
            return false;   
        }
    }
    
    public int selectPlaylistFaixa(String descricao){
        PlaylistDAO playlistDAO = new PlaylistDAO();
        return playlistDAO.selectPlaylistFaixa(descricao);
    }
}
