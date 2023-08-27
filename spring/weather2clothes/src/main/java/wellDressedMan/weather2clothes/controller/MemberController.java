package wellDressedMan.weather2clothes.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import wellDressedMan.weather2clothes.domain.Member;
import wellDressedMan.weather2clothes.service.MemberService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

//    @GetMapping("/{}") // /home/{itemId}로 get요청이 들어올때
//    public String member(@PathVariable long itemId, Model model) { //@PathVariable : URI경로 중 변수처리된 부분을 파라미터로 받는다
//        Member member = MemberService.findByMbrId(itemId).get();
//        model.addAttribute("item", item);
//        return member;
//    }

    @PostMapping("/register")
    public ResponseEntity<String> registerMember(@RequestBody Member member) {
        //중복이메일 확인
        Member existingMember = memberService.findByMbrId(member.getMbrId()).get(); //중복여부만 따질려면 Member객체를 return할 필요는X, 나중에 이 메써드를 어떻게 또 사용할지 모르니 일단 Member객체 return하는 형태로 만들어두기
        if (existingMember != null) {
            return ResponseEntity.badRequest().body("A member with that email address already exists.");
        }
        //저장
        memberService.createMember(member);
        return ResponseEntity.ok("Member registered successfully.");
    }


    @Value("${resources.location}")
    private String resourceLocation;

    @PostMapping("/region")
    public ResponseEntity<String> resetRegionList() throws IOException {

        String fileLocation = resourceLocation + "/init/regionList.csv"; // 설정파일에 설정된 경로 뒤에 붙인다
        Path path = Paths.get(fileLocation);
        URI uri = path.toUri();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                new UrlResource(uri).getInputStream()))
        ) {
            String line = br.readLine(); // head 떼기
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ResponseEntity.ok("초기화에 성공했습니다");
    }

//    @GetMapping("/login")
//    public ResponseEntity<String> registerMember(@RequestBody Member member) {
//        //중복이메일 확인
//        Member existingMember = memberService.findByMbrId(member.getMbrId()).get(); //중복여부만 따질려면 Member객체를 return할 필요는X, 나중에 이 메써드를 어떻게 또 사용할지 모르니 일단 Member객체 return하는 형태로 만들어두기
//        if (existingMember != null) {
//            return ResponseEntity.badRequest().body("A member with that email address already exists.");
//        }
//        //저장
//        memberService.createMember(member);
//        return ResponseEntity.ok("Member registered successfully.");
//    }
}
