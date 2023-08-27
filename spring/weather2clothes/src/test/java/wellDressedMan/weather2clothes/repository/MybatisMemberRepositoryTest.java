package wellDressedMan.weather2clothes.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import wellDressedMan.weather2clothes.domain.Member;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class MybatisMemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    @Test
    void createMember() {
        //given
        Member member = new Member(1L, "id", "pwd");

        //when
        Member createdMember = memberRepository.createMember(member);

        //then
        Member findMember = memberRepository.findByMbrId(member.getMbrId()).get();
        assertThat(findMember).isEqualTo(member);
    }

    @Test
    void findByMbrId() {
    }
}