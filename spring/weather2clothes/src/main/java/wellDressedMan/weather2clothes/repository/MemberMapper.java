package wellDressedMan.weather2clothes.repository;

import org.apache.ibatis.annotations.Mapper;
import wellDressedMan.weather2clothes.domain.Member;

import java.util.Optional;

@Mapper
public interface MemberMapper {
    void createMember(Member member);
    Optional<Member> findByMbrId(String MbrId);

}
