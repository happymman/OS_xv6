package wellDressedMan.weather2clothes.dto;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class ResponseDTO {
    private WeatherResponse weatherResponse;
    private String message;
}
