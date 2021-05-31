/**
 * Provides models for the `org.springframework.util` package.
 */
import java

/**
 * Provides models for the `org.springframework.util` package.
 */
module SpringUtil {
  private class FlowSummaries extends SummaryModelCsv {
    override predicate row(string row) {
      row = [
        "org.springframework.util;AutoPopulatingList;false;AutoPopulatingList;(java.util.List<E>, org.springframework.util.AutoPopulatingList$ElementFactory<E>);;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;AutoPopulatingList;false;AutoPopulatingList;(java.util.List<E>, Class<? extends E>);;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;Base64Utils;false;decode;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;decodeFromString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;decodeFromUrlSafeString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;decodeUrlSafe;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;encode;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;encodeToString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;encodeToUrlSafeString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;Base64Utils;false;encodeUrlSafe;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;CollectionUtils;false;arrayToList;;;Element of Argument[0];Element of ReturnValue;value",
        // find in argument[0] an element of argument[1]; I think exclude because it can be used to sanitize.
        //"org.springframework.util;CollectionUtils;false;findFirstMatch;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;findValueOfType;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;firstElement;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;lastElement;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;mergeArrayIntoCollection;;;Element of Argument[0];Element of Argument[1];value",
        "org.springframework.util;CollectionUtils;false;mergePropertiesIntoMap;;;MapKey of Argument[0];MapKey of Argument[1];value",
        "org.springframework.util;CollectionUtils;false;mergePropertiesIntoMap;;;MapValue of Argument[0];MapValue of Argument[1];value",
        "org.springframework.util;CollectionUtils;false;toArray;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;toArray;;;Element of Argument[0];Element of Argument[1];value",
        "org.springframework.util;CollectionUtils;false;toIterator;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;toMultiValueMap;;;MapKey of Argument[0];MapKey of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;toMultiValueMap;;;Element of MapValue of Argument[0];MapValue of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;unmodifiableMultiValueMap;;;MapKey of Argument[0];MapKey of ReturnValue;value",
        "org.springframework.util;CollectionUtils;false;unmodifiableMultiValueMap;;;MapValue of Argument[0];MapValue of ReturnValue;value",
        "org.springframework.util;CompositeIterator;false;add;;;Element of Argument[0];Element of Argument[-1];value",
        "org.springframework.util;CompositeIterator;false;next;;;Element of Argument[-1];ReturnValue;value",
        "org.springframework.util.ConcurrentReferenceHashMap;Reference;false;get;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util.ConcurrentReferenceHashMap;Reference;false;get;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util.ConcurrentReferenceHashMap;Reference;false;get;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util.ConcurrentReferenceHashMap;Segment;false;getReference;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util.ConcurrentReferenceHashMap;Segment;false;getReference;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util;ConcurrentReferenceHashMap;false;getReference;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util;ConcurrentReferenceHashMap;false;getReference;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util;ConcurrentReferenceHashMap;false;getSegment;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util;ConcurrentReferenceHashMap;false;getSegment;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        // skipped md5 digest
        "org.springframework.util;FastByteArrayOutputStream;false;getInputStream;;;Argument[-1];ReturnValue;taint",
        "org.springframework.util;FastByteArrayOutputStream;false;toByteArray;;;Argument[-1];ReturnValue;taint",
        "org.springframework.util;FastByteArrayOutputStream;false;write;;;Argument[0];Argument[-1];taint",
        "org.springframework.util;FastByteArrayOutputStream;false;writeTo;;;Argument[-1];Argument[0];taint",
        "org.springframework.util;FileCopyUtils;false;copy;;;Argument[0];Argument[1];taint",
        "org.springframework.util;FileCopyUtils;false;copyToByteArray;;;Argument[0];Argument[-1];taint",
        "org.springframework.util;FileCopyUtils;false;copyToString;;;Argument[0];Argument[-1];taint",
        "org.springframework.util;FileSystemUtils;false;copyRecursively;;;Argument[0];Argument[-1];taint",
        "org.springframework.util;LinkedMultiValueMap;false;LinkedMultiValueMap;(Map<K,List<V>>);;MapKey of Argument[0];MapKey of ReturnValue;value",
        "org.springframework.util;LinkedMultiValueMap;false;LinkedMultiValueMap;(Map<K,List<V>>);;Element of MapValue of Argument[0];MapValue of ReturnValue;value",
        "org.springframework.util;LinkedMultiValueMap;false;deepCopy;;;MapKey of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util;LinkedMultiValueMap;false;deepCopy;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util;MultiValueMap;true;add;;;Argument[0];MapKey of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;add;;;Argument[1];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;addAll;;;Argument[0];MapKey of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;addAll;(K, java.util.List<? extends V>);;Element of Argument[1];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;addAll;(MultiValueMap<K,V>);;MapValue of Argument[0];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;addIfAbsent;;;Argument[0];MapKey of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;addIfAbsent;;;Argument[1];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;getFirst;;;MapValue of Argument[-1];ReturnValue;value",
        "org.springframework.util;MultiValueMap;true;set;;;Argument[0];MapKey of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;set;;;Argument[1];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;setAll;;;MapKey of Argument[0];MapKey of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;setAll;;;MapValue of Argument[0];MapValue of Argument[-1];value",
        "org.springframework.util;MultiValueMap;true;toSingleValueMap;;;MapKey of Argument[-1];MapKey of ReturnValue;value",
        "org.springframework.util;MultiValueMap;true;toSingleValueMap;;;MapValue of Argument[-1];MapValue of ReturnValue;value",
        "org.springframework.util;MultiValueMapAdapter;false;MultiValueMapAdapter;;;MapKey of Argument[0];MapKey of ReturnValue;value",
        "org.springframework.util;MultiValueMapAdapter;false;MultiValueMapAdapter;;;Element of MapValue of Argument[0];MapValue of ReturnValue;value",
        "org.springframework.util;ObjectUtils;false;addObjectToArray;;;Argument[1];Element of Argument[0];value",
        "org.springframework.util;ObjectUtils;false;getDisplayString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ObjectUtils;false;identityToString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ObjectUtils;false;nullSafeToString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ObjectUtils;false;toObjectArray;;;Element of Argument[0];Element of ReturnValue;value",
        "org.springframework.util;ObjectUtils;false;unwrapOptional;;;Element of Argument[0];ReturnValue;value",
        "org.springframework.util;PropertiesPersister;true;load;;;Argument[1];Argument[0];taint",
        "org.springframework.util;PropertiesPersister;true;loadFromXml;;;Argument[1];Argument[0];taint",
        "org.springframework.util;PropertiesPersister;true;store;;;Argument[0];Argument[1];taint",
        "org.springframework.util;PropertiesPersister;true;store;;;Argument[2];Argument[1];taint",
        "org.springframework.util;PropertiesPersister;true;storeToXml;;;Argument[0];Argument[1];taint",
        "org.springframework.util;PropertiesPersister;true;storeToXml;;;Argument[2];Argument[1];taint",
        "org.springframework.util;PropertyPlaceholderHelper;false;PropertyPlaceholderHelper;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;PropertyPlaceholderHelper;false;parseStringValue;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;PropertyPlaceholderHelper;false;replacePlaceholders;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;PropertyPlaceholderHelper;false;replacePlaceholders;(java.lang.String, java.util.Properties);;MapValue of Argument[1];ReturnValue;taint",
        "org.springframework.util;ResourceUtils;false;extractArchiveUrl;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ResourceUtils;false;extractJarFileURL;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ResourceUtils;false;getFile;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;ResourceUtils;false;getURI;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;RouteMatcher;true;combine;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;RouteMatcher;true;matchAndExtract;;;Argument[0];MapKey of ReturnValue;taint",
        "org.springframework.util;RouteMatcher;true;matchAndExtract;;;Argument[1];MapValue of ReturnValue;taint",
        "org.springframework.util;RouteMatcher;true;parseRoute;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;SerializationUtils;false;deserialize;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;SerializationUtils;false;serialize;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StreamUtils;false;copy;(byte[], java.io.OutputStream);;Argument[0];Argument[1];taint",
        "org.springframework.util;StreamUtils;false;copy;(java.io.InputStream, java.io.OutputStream);;Argument[0];Argument[1];taint",
        "org.springframework.util;StreamUtils;false;copy;(java.lang.String, java.nio.Charset, java.io.OutputStream);;Argument[0];Argument[2];taint",
        "org.springframework.util;StreamUtils;false;copyRange;;;Argument[0];Argument[1];taint",
        "org.springframework.util;StreamUtils;false;copyToByteArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StreamUtils;false;copyToString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;addStringToArray;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;applyRelativePath;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;arrayToCommaDelimitedString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;arrayToDelimitedString;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;capitalize;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;cleanPath;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;collectionToCommaDelimitedString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;collectionToDelimitedString;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;collectionToDelimitedString;(java.util.Collection,java.lang.String,java.lang.String,java.lang.String);;Argument[2..3];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;commaDelimitedListToSet;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;commaDelimitedListToStringArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;concatenateStringArrays;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;delete;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;deleteAny;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;delimitedListToStringArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;getFilename;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;getFilenameExtension;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;mergeStringArrays;;;Argument[0..1];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;quote;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;quoteIfString;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;removeDuplicateStrings;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;replace;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;replace;;;Argument[2];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;sortStringArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;split;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;splitArrayElementsIntoProperties;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;stripFilenameExtension;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;tokenizeToStringArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;toStringArray;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimAllWhitespace;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimArrayElements;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimLeadingCharacter;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimLeadingWhitespace;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimTrailingCharacter;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimTrailingWhitespace;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;trimWhitespace;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;uncapitalize;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;unqualify;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;StringUtils;false;uriDecode;;;Argument[0];ReturnValue;taint"
        "org.springframework.util;StringValueResolver;false;resolveStringValue;;;Argument[0];ReturnValue;taint",
        "org.springframework.util;SystemPropertyUtils;false;resolvePlaceholders;;;Argument[0];ReturnValue;taint",
      ]
    }
  }
}
