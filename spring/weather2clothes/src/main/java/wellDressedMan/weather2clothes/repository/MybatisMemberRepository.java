package wellDressedMan.weather2clothes.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import wellDressedMan.weather2clothes.domain.Member;

import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class MybatisMemberRepository implements MemberRepository {
    private final MemberMapper memberMapper;

    @Override
    public Member createMember(Member member) {
        memberMapper.createMember(member);
        return member;
    }

    @Override
    public Optional<Member> findByMbrId(String mbrId) {
        return memberMapper.findByMbrId(mbrId);
    }
}
