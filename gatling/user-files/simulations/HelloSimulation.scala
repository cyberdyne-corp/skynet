package skynet.stress

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class HelloSimulation extends Simulation {

val httpProtocol = http
    //.baseURL("http://192.168.2.75")
    .baseURL("http://INSERT-ROUTABLE-IP")
    .acceptHeader("application/json, text/plain, */*")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .connection("keep-alive")
    .contentTypeHeader("application/json; charset=UTF-8")
    .userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0")

  val scn = scenario("HelloSimulation")
    .exec(http("request_1")
    .get("/"))
    //.pause(5)


	setUp(
	  scn.inject(
		rampUsersPerSec(10) to 300 during(2 minutes)
	  )
	).protocols(httpProtocol)



}

