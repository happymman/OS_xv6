package wellDressedMan.weather2clothes.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import wellDressedMan.weather2clothes.repository.MemberMapper;
import wellDressedMan.weather2clothes.repository.MemberRepository;
import wellDressedMan.weather2clothes.repository.MybatisMemberRepository;
import wellDressedMan.weather2clothes.service.MemberService;
import wellDressedMan.weather2clothes.service.MemberServiceV1;

@Configuration
@RequiredArgsConstructor
public class MybatisConfig {

    private final MemberMapper memberMapper;

    @Bean
    public MemberService memberService(){return new MemberServiceV1(memberRepository());}

    @Bean
    public MemberRepository memberRepository(){return new MybatisMemberRepository(memberMapper);
    }

}
