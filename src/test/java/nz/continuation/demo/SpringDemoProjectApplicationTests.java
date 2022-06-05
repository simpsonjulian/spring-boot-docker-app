package nz.continuation.demo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;


@SpringBootTest
class SpringDemoProjectApplicationTests {

	@Autowired
	private ApplicationController controller;

	@Test
	void contextLoads() {
		assertThat(controller).isNotNull();
	}

}
