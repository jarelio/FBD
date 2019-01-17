
package model.dao;

import java.sql.Connection;
import connection.ConnectionFactory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.bean.Playlist;

/**
 *
 * @author Jarelio Filho
 */
public class PlaylistDAO {
    
    private Connection con = null;

    public PlaylistDAO() {
        con = ConnectionFactory.conectar();
    }
    
    public boolean inserir(Playlist playlist){
        
        String sql = "INSERT INTO playlist VALUES (?,?,?,?)";
        
        PreparedStatement stmt = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,playlist.getCodPlay());
            stmt.setString(2,playlist.getNome());
            stmt.setTimestamp(3,playlist.getDataCriacao());
            stmt.setTime(4,playlist.getDuracaoExec());
            stmt.executeUpdate();       
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt);
        }
        
    } 
    
    public List<Playlist> getPlaylists(){
        
        List<Playlist> playlists = new ArrayList<>();
        
        String sql = "SELECT * FROM playlist ORDER BY(3) desc";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                Playlist playlist = new Playlist();
                playlist.setCodPlay(rs.getInt(1));
                playlist.setNome(rs.getString(2));
                playlist.setDataCriacao(rs.getTimestamp(3));
                playlist.setDuracaoExec(rs.getTime(4));
                playlists.add(playlist);
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return playlists;
    }
    
    public boolean delete(int cod_play){
        
        String sql = "DELETE FROM playlist WHERE cod_play=?";
        
        PreparedStatement stmt = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, cod_play);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt);
        }
        
    }
    public int selectPlaylistFaixa(String descricao){       
        String sql = "select fp.cod_play from faixa_playlist fp, faixa f where f.descricao=? and fp.numero_faixa=f.numero_faixa and fp.cod_album=f.cod_album";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int cod_play = 0;
        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, descricao);
            rs = stmt.executeQuery();
            while(rs.next()){
                cod_play = rs.getInt(1);
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return cod_play;        
    }
}
