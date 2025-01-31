/**
 * @name Use of a broken or risky cryptographic algorithm
 * @description Using broken or weak cryptographic algorithms can allow
 *              an attacker to compromise security.
 * @kind problem
 * @problem.severity error
 * @precision medium
 * @id cpp/weak-cryptographic-algorithm
 * @tags security
 *       external/cwe/cwe-327
 */

import cpp
import semmle.code.cpp.security.Encryption

/**
 * A function which may relate to an insecure encryption algorithm.
 */
Function getAnInsecureEncryptionFunction() {
  (
    isInsecureEncryption(result.getName()) or
    isInsecureEncryption(result.getAParameter().getName()) or
    isInsecureEncryption(result.getDeclaringType().getName())
  ) and
  exists(result.getACallToThisFunction())
}

/**
 * A function with additional evidence it is related to encryption.
 */
Function getAnAdditionalEvidenceFunction() {
  (
    isEncryptionAdditionalEvidence(result.getName()) or
    isEncryptionAdditionalEvidence(result.getAParameter().getName())
  ) and
  exists(result.getACallToThisFunction())
}

/**
 * A macro which may relate to an insecure encryption algorithm.
 */
Macro getAnInsecureEncryptionMacro() {
  isInsecureEncryption(result.getName()) and
  exists(result.getAnInvocation())
}

/**
 * A macro with additional evidence it is related to encryption.
 */
Macro getAnAdditionalEvidenceMacro() {
  isEncryptionAdditionalEvidence(result.getName()) and
  exists(result.getAnInvocation())
}

/**
 * An enum constant which may relate to an insecure encryption algorithm.
 */
EnumConstant getAnInsecureEncryptionEnumConst() { isInsecureEncryption(result.getName()) }

/**
 * An enum constant with additional evidence it is related to encryption.
 */
EnumConstant getAdditionalEvidenceEnumConst() { isEncryptionAdditionalEvidence(result.getName()) }

/**
 * A function call we have a high confidence is related to use of an insecure encryption algorithm, along
 * with an associated `Element` which might be the best point to blame, and a description of that element.
 */
predicate getInsecureEncryptionEvidence(FunctionCall fc, Element blame, string description) {
  // find use of an insecure algorithm name
  (
    fc.getTarget() = getAnInsecureEncryptionFunction() and
    blame = fc and
    description = "call to " + fc.getTarget().getName()
    or
    exists(MacroInvocation mi |
      (
        mi.getAnExpandedElement() = fc or
        mi.getAnExpandedElement() = fc.getAnArgument()
      ) and
      mi.getMacro() = getAnInsecureEncryptionMacro() and
      blame = mi and
      description = "invocation of macro " + mi.getMacro().getName()
    )
    or
    exists(EnumConstantAccess ec |
      ec = fc.getAnArgument() and
      ec.getTarget() = getAnInsecureEncryptionEnumConst() and
      blame = ec and
      description = "access of enum constant " + ec.getTarget().getName()
    )
  ) and
  // find additional evidence that this function is related to encryption.
  (
    fc.getTarget() = getAnAdditionalEvidenceFunction()
    or
    exists(MacroInvocation mi |
      (
        mi.getAnExpandedElement() = fc or
        mi.getAnExpandedElement() = fc.getAnArgument()
      ) and
      mi.getMacro() = getAnAdditionalEvidenceMacro()
    )
    or
    exists(EnumConstantAccess ec |
      ec = fc.getAnArgument() and
      ec.getTarget() = getAdditionalEvidenceEnumConst()
    )
  )
}

/**
 * An element that is the `blame` of an `InsecureFunctionCall`.
 */
class BlamedElement extends Element {
  string description;

  BlamedElement() { getInsecureEncryptionEvidence(_, this, description) }

  /**
   * Holds if this is the `num`-th `BlamedElement` in `f`.
   */
  predicate hasFileRank(File f, int num) {
    exists(int loc |
      getLocation().charLoc(f, loc, _) and
      loc =
        rank[num](BlamedElement other, int loc2 | other.getLocation().charLoc(f, loc2, _) | loc2)
    )
  }

  string getDescription() { result = description }
}

from File f, BlamedElement firstResult, BlamedElement thisResult
where
  firstResult.hasFileRank(f, 1) and
  thisResult.hasFileRank(f, _)
select firstResult,
  "This file makes use of a broken or weak cryptographic algorithm (specified by $@).", thisResult,
  thisResult.getDescription()
