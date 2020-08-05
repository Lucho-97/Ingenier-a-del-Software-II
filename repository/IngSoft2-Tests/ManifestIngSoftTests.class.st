"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftTests,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleGRTemporaryNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2020-08-05T04:08:17.725411-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2020-08-04T07:10:43.935818-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2020-08-05T03:57:36.480659-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleRBUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2020-08-04T07:10:40.126534-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleReTestClassNameShouldEndWithTestV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Tests')) #'2020-08-05T04:29:28.903001-03:00') )
]
