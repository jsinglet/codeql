import org.apache.commons.lang3.text.StrSubstitutor;
import org.apache.commons.lang3.text.StrLookup;
import org.apache.commons.lang3.text.StrMatcher;
import org.apache.commons.lang3.text.StrBuilder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

class StrSubstitutorTest {
    String taint() { return "tainted"; }

    void sink(Object o) {}

    void test() throws Exception {
      Map<String, String> taintedMap = new HashMap<String, String>();
      taintedMap.put("key", taint());
      StrLookup<String> taintedLookup = StrLookup.mapLookup(taintedMap);

      // Test constructors:
      StrSubstitutor ss1 = new StrSubstitutor(); ss1.setVariableResolver(taintedLookup); sink(ss1.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss2 = new StrSubstitutor(taintedMap); sink(ss2.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss3 = new StrSubstitutor(taintedMap, "{", "}"); sink(ss3.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss4 = new StrSubstitutor(taintedMap, "{", "}", ' '); sink(ss4.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss5 = new StrSubstitutor(taintedMap, "{", "}", ' ', ","); sink(ss5.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss6 = new StrSubstitutor(taintedLookup); sink(ss6.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss7 = new StrSubstitutor(taintedLookup, "{", "}", ' '); sink(ss7.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss8 = new StrSubstitutor(taintedLookup, "{", "}", ' ', ","); sink(ss8.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss9 = new StrSubstitutor(taintedLookup, (StrMatcher)null, null, ' '); sink(ss9.replace("input")); // $hasTaintFlow=y
      StrSubstitutor ss10 = new StrSubstitutor(taintedLookup, (StrMatcher)null, null, ' ', null); sink(ss10.replace("input")); // $hasTaintFlow=y

      // Test replace overloads (tainted substitution map):
      StrSubstitutor taintedSubst = ss2;
      sink(taintedSubst.replace((Object)"input")); // $hasTaintFlow=y
      sink(taintedSubst.replace("input")); // $hasTaintFlow=y
      sink(taintedSubst.replace("input", 0, 0)); // $hasTaintFlow=y
      sink(taintedSubst.replace("input".toCharArray())); // $hasTaintFlow=y
      sink(taintedSubst.replace("input".toCharArray(), 0, 0)); // $hasTaintFlow=y
      sink(taintedSubst.replace((CharSequence)"input")); // $hasTaintFlow=y
      sink(taintedSubst.replace((CharSequence)"input", 0, 0)); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StrBuilder("input"))); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StrBuilder("input"), 0, 0)); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StringBuilder("input"))); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StringBuilder("input"), 0, 0)); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StringBuffer("input"))); // $hasTaintFlow=y
      sink(taintedSubst.replace(new StringBuffer("input"), 0, 0)); // $hasTaintFlow=y

      // Test replace overloads (tainted input):
      StrSubstitutor untaintedSubst = ss1;
      sink(untaintedSubst.replace((Object)taint())); // $hasTaintFlow=y
      sink(untaintedSubst.replace(taint())); // $hasTaintFlow=y
      sink(untaintedSubst.replace(taint(), 0, 0)); // $hasTaintFlow=y
      sink(untaintedSubst.replace(taint().toCharArray())); // $hasTaintFlow=y
      sink(untaintedSubst.replace(taint().toCharArray(), 0, 0)); // $hasTaintFlow=y
      sink(untaintedSubst.replace((CharSequence)taint())); // $hasTaintFlow=y
      sink(untaintedSubst.replace((CharSequence)taint(), 0, 0)); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StrBuilder(taint()))); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StrBuilder(taint()), 0, 0)); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StringBuilder(taint()))); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StringBuilder(taint()), 0, 0)); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StringBuffer(taint()))); // $hasTaintFlow=y
      sink(untaintedSubst.replace(new StringBuffer(taint()), 0, 0)); // $hasTaintFlow=y

      // Test static replace methods:
      sink(StrSubstitutor.replace(taint(), new HashMap<String, String>())); // $hasTaintFlow=y
      sink(StrSubstitutor.replace(taint(), new HashMap<String, String>(), "{", "}")); // $hasTaintFlow=y
      sink(StrSubstitutor.replace("input", taintedMap)); // $hasTaintFlow=y
      sink(StrSubstitutor.replace("input", taintedMap, "{", "}")); // $hasTaintFlow=y
      Properties taintedProps = new Properties();
      taintedProps.put("key", taint());
      sink(StrSubstitutor.replace(taint(), new Properties())); // $hasTaintFlow=y
      sink(StrSubstitutor.replace("input", taintedProps)); // $hasTaintFlow=y

      // Test replaceIn methods:
      StrBuilder strBuilder1 = new StrBuilder(); taintedSubst.replaceIn(strBuilder1); sink(strBuilder1.toString()); // $hasTaintFlow=y
      StrBuilder strBuilder2 = new StrBuilder(); taintedSubst.replaceIn(strBuilder2, 0, 0); sink(strBuilder2.toString()); // $hasTaintFlow=y
      StringBuilder stringBuilder1 = new StringBuilder(); taintedSubst.replaceIn(stringBuilder1); sink(stringBuilder1.toString()); // $hasTaintFlow=y
      StringBuilder stringBuilder2 = new StringBuilder(); taintedSubst.replaceIn(stringBuilder2, 0, 0); sink(stringBuilder2.toString()); // $hasTaintFlow=y
      StringBuffer stringBuffer1 = new StringBuffer(); taintedSubst.replaceIn(stringBuffer1); sink(stringBuffer1.toString()); // $hasTaintFlow=y
      StringBuffer stringBuffer2 = new StringBuffer(); taintedSubst.replaceIn(stringBuffer2, 0, 0); sink(stringBuffer2.toString()); // $hasTaintFlow=y
    }

}