
package model.dao;

import java.sql.Connection;
import connection.ConnectionFactory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.bean.Album;

/**
 *
 * @author Jarelio Filho
 */
public class AlbumDAO {
    
    private Connection con = null;

    public AlbumDAO() {
        con = ConnectionFactory.conectar();
    }
    
    public boolean inserirPlaylist(int cod_album, int cod_play){
        
        String sql = "SELECT * FROM faixa f WHERE f.cod_album=? and f.descricao not in(select f2.descricao from faixa f2 inner join faixa_playlist fp on f2.numero_faixa=fp.numero_faixa and f2.cod_album=fp.cod_album where fp.cod_play=?) ";
        String sql2 = "INSERT INTO faixa_playlist VALUES (?,?,?,?,?)";
        String sql3 = "UPDATE playlist SET duracao_exec=(SELECT CAST(tempo_exec_faixa3 as TIME) as tempo_exec_faixa4 from (SELECT CAST(CONVERT(FLOAT,tempo_exec_faixa2) as DATETIME) as tempo_exec_faixa3 \n" +
                      "from (select ISNULL((sum(CAST(CONVERT(DATETIME,tempo_exec_faixa) as FLOAT))),0) as tempo_exec_faixa2 from faixa f, faixa_playlist fp where f.numero_faixa=fp.numero_faixa and f.cod_album=fp.cod_album and fp.cod_play=?) teste) teste2) WHERE cod_play=?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,cod_album);
            stmt.setInt(2,cod_play);
            rs = stmt.executeQuery();

            while(rs.next()){
                stmt = con.prepareStatement(sql2);
                stmt.setInt(1,cod_play);
                stmt.setInt(2,rs.getInt(1));
                stmt.setInt(3,rs.getInt(2));
                stmt.setInt(4,0);
                stmt.setString(5,"10/10/10");
                stmt.executeUpdate();
            }
            stmt = con.prepareStatement(sql3);
            stmt.setInt(1, cod_play);
            stmt.setInt(2, cod_play);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
    }
    
    public List<Album> getAlbuns(){
        
        List<Album> albuns = new ArrayList<>();
        
        String sql = "SELECT cod_album,descricao FROM album ORDER BY(1) asc";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                Album album = new Album();
                album.setCodAlbum(rs.getInt(1));
                album.setDescricao(rs.getString(2));
                albuns.add(album);
            }
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return albuns;
    }
    
    public Album selectAlbumFaixa(int cod_album){
        String sql = "SELECT descricao FROM album WHERE cod_album=? ";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Album album = new Album();
        
        try {
            
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,cod_album);
            rs = stmt.executeQuery();
            while(rs.next()){
                album.setDescricao(rs.getString(1));
            }
            
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return album;
    }
    
    public Album select(int cod_album){
        String sql = "SELECT * FROM album WHERE cod_album=? ";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Album album = new Album();
        
        try {
            
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,cod_album);
            rs = stmt.executeQuery();
            while(rs.next()){
                album.setCodAlbum(rs.getInt(1));
                album.setCodGrav(rs.getInt(2));
                album.setDescricao(rs.getString(3));
                album.setPrecoCompra(rs.getFloat(4));
                album.setDataCompra(rs.getTimestamp(5));
                album.setTipoCompra(rs.getString(6));
                album.setDataGrav(rs.getDate(7));

            }
            
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        
        return album;
    }
    
    public boolean selectGravadora(int cod_grav){
        String sql = "SELECT * FROM gravadora WHERE cod_grav=? ";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,cod_grav);
            rs = stmt.executeQuery();
            return rs.next();
            
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
        }finally{
            ConnectionFactory.desconectar(con, stmt, rs);
        }
        return false;
    }
    
    public boolean update(int cod_album, int cod_grav, String descricao, float preco_compra, Date data_compra, String tipo_compra, Date data_grav){
        
        String sql = "UPDATE album SET cod_grav=?, descricao=?, preco_compra=?, data_compra=?, tipo_compra=?, data_grav=? WHERE cod_album=?";
        
        PreparedStatement stmt = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,cod_grav);
            stmt.setString(2, descricao);
            stmt.setFloat(3,preco_compra);           
            stmt.setTimestamp(4, new java.sql.Timestamp(data_compra.getTime()));
            stmt.setString(5,tipo_compra);
            stmt.setDate(6, new java.sql.Date(data_grav.getTime()));
            stmt.setInt(7, cod_album);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.err.println("Erro: "+ex);
            return false;
        }finally{
            ConnectionFactory.desconectar(con, stmt);
        }
                
    }
}
