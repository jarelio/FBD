/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.bean.Faixa;
import model.dao.FaixaDAO;

/**
 *
 * @author Jarelio Filho
 */
public class FaixaController {
    
    public List<Faixa> selectFaixasPlaylist(int cod_play){
        FaixaDAO faixaDAO = new FaixaDAO();
        List<Faixa> faixas;
        faixas = faixaDAO.selectFaixasPlaylist(cod_play);
        return faixas;
    }
    
    public boolean deleteFaixaPlaylist(int numero_faixa,int cod_album, int cod_play){
        FaixaDAO faixaDAO = new FaixaDAO();
        if(faixaDAO.delete(numero_faixa, cod_album, cod_play)){
            System.out.println("Faixa deletada com sucesso da Playlist!");
            return true; 
        }else{
            System.err.println("Falha ao deletar a faixa da Playlist!");
            return false;   
        }
    }
    
    public Faixa selectFaixaDescricao(String descricao){
        FaixaDAO faixaDAO = new FaixaDAO();
        return faixaDAO.selectFaixaDescricao(descricao);
    }
    
    public boolean inserirPlaylist(int numero_faixa, int cod_play, int cod_album) {
        
        FaixaDAO faixaDAO = new FaixaDAO();
        
        if(faixaDAO.inserirPlaylist(numero_faixa,cod_play, cod_album)){
            System.out.println("Faixa adicionado na playlist com sucesso!");
            return true;
        }else{
            System.err.println("Erro ao inserir faixa na playlist!");
            return false;
        }
    }
    
    public List<Faixa> selectFaixasAlbum(int cod_album){
        FaixaDAO faixaDAO = new FaixaDAO();
        List<Faixa> faixas;
        faixas = faixaDAO.selectFaixasAlbum(cod_album);
        return faixas;
    }
}
