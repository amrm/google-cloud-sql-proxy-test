package spring.cloud.google.cloud.com.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@RestController
public class WebController {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @GetMapping("/check")
    public ResponseEntity<String> check() {
        return new ResponseEntity<String>("status UP", HttpStatus.OK);
    }

    @GetMapping("/status")
    public ResponseEntity<String> status() {
        return new ResponseEntity<String>("status UP", HttpStatus.OK);
    }

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot!  jdbc:mysql://clouddb/report?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=yes&characterEncoding=UTF-8";
    }

    @GetMapping("/users")
    public ResponseEntity<String> getUsers() {
        List users = jdbcTemplate.query("select * from users", new RowMapper<Object>(){
            public String mapRow(ResultSet rs, int rowNum)
                    throws SQLException {
                return rs.getString("NAME");
            }});
        String response="";
        for(Object s:users){
            response+=s+" , ";
        }

        return new ResponseEntity<String>(response, HttpStatus.OK);
    }

}
