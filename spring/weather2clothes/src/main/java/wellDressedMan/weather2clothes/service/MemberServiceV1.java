package wellDressedMan.weather2clothes.service;//package happyman.sugang.service;

import lombok.RequiredArgsConstructor;
import wellDressedMan.weather2clothes.domain.Member;
import wellDressedMan.weather2clothes.repository.MemberRepository;

import java.util.Optional;

@RequiredArgsConstructor
//@Service
public class MemberServiceV1 implements MemberService {
    private final MemberRepository memberRepository;

    @Override
    public Member createMember(Member member) {
        return memberRepository.createMember(member);
    }

    @Override
    public Optional<Member> findByMbrId(String mbrId) {
        return memberRepository.findByMbrId(mbrId);
    }

}
