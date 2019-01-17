/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import java.util.Date;
import java.util.List;
import model.bean.Album;
import model.dao.AlbumDAO;


/**
 *
 * @author Jarelio Filho
 */
public class AlbumController {

    public List<Album> getAlbuns(){
        AlbumDAO albumDAO = new AlbumDAO();
        List<Album> albuns;
        albuns = albumDAO.getAlbuns();
        return albuns;
    }
    
    public boolean inserirPlaylist(int cod_album, int cod_play) {
        
        AlbumDAO albumdao = new AlbumDAO();
        
        if(albumdao.inserirPlaylist(cod_album,cod_play)){
            System.out.println("Album adicionado na playlist com sucesso!");
            return true;
        }else{
            System.err.println("Erro ao inserir faixas na playlist!");
            return false;
        }
    }
    
    public Album getAlbumFaixa(int cod_album){
        AlbumDAO albumDAO = new AlbumDAO();
        Album album;
        album = albumDAO.selectAlbumFaixa(cod_album);
        return album;
    }
    
    public Album selectAlbum(int cod_album){
        AlbumDAO albumDAO = new AlbumDAO();
        Album album;
        album = albumDAO.select(cod_album);
        return album;
    }
    
    public boolean getGravadora(int cod_grav){
        AlbumDAO albumdao = new AlbumDAO();
        
        if(albumdao.selectGravadora(cod_grav)){
            System.out.println("Existe gravadora com este código");
            return true;
        }else{
            System.err.println("Não existe gravadora com este código");
            return false;
        }        
    }
    
    public boolean updateAlbum(int cod_album,int cod_grav, String descricao, float preco_compra, Date data_compra, String tipo_compra, Date data_grav){
        AlbumDAO albumdao = new AlbumDAO();
        
        if(albumdao.update(cod_album,cod_grav,descricao,preco_compra,data_compra,tipo_compra,data_grav)){
            System.out.println("Album atualizado com sucesso!");
            return true;
        }else{
            System.err.println("Falha ao atualizar album!");
            return false;
        }         
    }
}
