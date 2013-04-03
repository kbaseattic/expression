<?xml version="1.0" encoding="UTF-8"?>
<Database xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:noNamespaceSchemaLocation="http://bio-macpro-1.mcs.anl.gov/~parrello/FIG/Html/ERDB_DBD.xsd">
  <Title>Knowledge Base Bioinformatics Database</Title>
  <Notes>This document is used to create the central store for the KBase
  project. The document itself is called the [i]Central Data Model[/i],
  and a database created from it is called a [i]Central Data Model
  Instance[/i]. In addition to the Central Store, private CDMI
  databases can be created, and these are sometimes referred to as
  [i]Tiny Stores[/i].</Notes>
  <Regions>
    <Region name="Chemistry">
      <Notes>The Chemistry region contains data about reactions, compounds, locations, and media conditions.</Notes>
    </Region>
    <Region name="Annotations">
      <Notes>The Annotations region contains feature annotation history, information
      about functional coupling, and annotation clearinghouse
      assertions.</Notes>
    </Region>
    <Region name="Models">
      <Notes>The Models region contains data related to metabolic flux models.</Notes>
    </Region>
    <Region name="Expression">
      <Notes>The Expression region contains data related to gene expression and
      regulation.</Notes>
    </Region>
    <Region name="Alignments">
      <Notes>The Alignments region contains data related to alignments and trees
      of features and proteins, organized into projects related by roles.</Notes>
    </Region>
    <Region name="Subsystem">
      <Notes>The subsystem region contains data related to subsystems and
      subsystem spreadsheets</Notes>
    </Region>
    <Region name="GenoPheno">
      <Notes>The Genotype to Phenotype region contains data about the relationship between experimentally determined alleles in a DNA sequence and observed traits for plants.</Notes>
    </Region>
    <Region name="Experiment">
      <Notes>The Experiment region contains general experimental data. More 
      specialized experimental data, such as expression data, links to 
      ExperimentalUnit such that multiple experiment types (e.g. fitness 
      and gene expression) may be tracked as part of one overarching 
      experiment.</Notes>
    </Region>
    <Region name="Strain">
      <Notes>The Strain region contains data modeling strains of organisms derived
      from a parent genome and their relationships.</Notes>
    </Region>
	<Region name="Expression_v2">
      <Notes>The expression_v2 contains expression data for various expression experiments (Microarray, RNA-Seq, proteomics, qPCR).
				It will eventually replace any existing expression schema.</Notes>
    </Region>
  </Regions>
  <Diagram height="800" width="700" ratio="0.7" size="90"
    fontSize="12" editable="1" />
  <Entities>
    <Entity name="LocationInstance" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" row="1" col="1"
          caption="Location\nInstance" />
      </DisplayInfo>
      <Notes>The Location Instance represents a region of a cell
       (e.g. cell wall, cytoplasm) as it appears in a specific
       model.</Notes>
      <Fields>
        <Field name="index" type="int">
          <Notes>number used to distinguish between different
           instances of the same type of location in a single
           model. Within a model, any two instances of the same
           location must have difference compartment index
           values.</Notes>
        </Field>
        <Field name="label" type="string" relation="ModelCompartmentLabel">
          <Notes>description used to differentiate between instances
           of the same location in a single model</Notes>
        </Field>
        <Field name="pH" type="float">
          <Notes>pH of the cell region, which is used to determine compound
          charge and pH gradient across cell membranes</Notes>
        </Field>
        <Field name="potential" type="float">
          <Notes>electrochemical potential of the cell region, which is used to
          determine the electrochemical gradient across cell membranes</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="CompoundInstance" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" row="5" col="3"
          caption="Compound\nInstance" />
      </DisplayInfo>
      <Notes>A Compound Instance represents the occurrence of a particular
      compound in a location in a model.</Notes>
      <Fields>
        <Field name="charge" type="float">
          <Notes>computed charge based on the location instance pH
          and similar constraints</Notes>
        </Field>
        <Field name="formula" type="string">
          <Notes>computed chemical formula for this compound based
          on the location instance pH and similar constraints</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Biomass" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" row="3" col="3" />
      </DisplayInfo>
      <Notes>A biomass is a collection of compounds in a specific
      ratio and in specific compartments that are necessary for a
      cell to function properly. The prediction of biomasses is key
      to the functioning of the model. Each biomass belongs to
      a specific model.</Notes>
      <Fields>
        <Field name="mod-date" type="date">
          <Notes>last modification date of the biomass data</Notes>
        </Field>
        <Field name="name" type="string" relation="BiomassName">
          <Notes>descriptive name for this biomass</Notes>
        </Field>
        <Field name="dna" type="float">
          <Notes>portion of a gram of this biomass (expressed as a
          fraction of 1.0) that is DNA</Notes>
        </Field>
        <Field name="protein" type="float">
          <Notes>portion of a gram of this biomass (expressed as a
          fraction of 1.0) that is protein</Notes>
        </Field>
        <Field name="cell-wall" type="float">
          <Notes>portion of a gram of this biomass (expressed as a
          fraction of 1.0) that is cell wall</Notes>
        </Field>
        <Field name="lipid" type="float">
          <Notes>portion of a gram of this biomass (expressed as a
          fraction of 1.0) that is lipid but is not part of the cell
          wall</Notes>
        </Field>
        <Field name="cofactor" type="float">
          <Notes>portion of a gram of this biomass (expressed as a
          fraction of 1.0) that function as cofactors</Notes>
        </Field>
        <Field name="energy" type="float">
          <Notes>number of ATP molecules hydrolized per gram of
          this biomass</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="ReactionInstance" keyType="string">
      <DisplayInfo theme="navy" caption="Reaction\nInstance">
        <RegionInfo name="Models" row="5" col="5" />
      </DisplayInfo>
      <Notes>A reaction instance describes the specific implementation of
      a reaction in a model.</Notes>
      <Fields>
        <Field name="direction" type="char">
          <Notes>reaction directionality (&gt; for forward, &lt; for
          backward, = for bidirectional) with respect to this model</Notes>
        </Field>
        <Field name="protons" type="float">
          <Notes>number of protons produced by this reaction when
          proceeding in the forward direction. If this is a transport
          reaction, these protons end up in the reaction instance's
          main location. If the number is negative, then the protons
          are consumed by the reaction rather than being produced.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Model" keyType="string">
      <DisplayInfo col="7" row="7" theme="navy">
        <RegionInfo name="Models" row="1" col="3" />
      </DisplayInfo>
      <Notes>A model specifies a relationship between sets of features and
      reactions in a cell. It is used to simulate cell growth and gene
      knockouts to validate annotations.</Notes>
      <Fields>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last change to the model data</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>descriptive name of the model</Notes>
        </Field>
        <Field name="version" type="int">
          <Notes>revision number of the model</Notes>
        </Field>
        <Field name="type" type="string">
          <Notes>string indicating where the model came from
          (e.g. single genome, multiple genome, or community model)</Notes>
        </Field>
        <Field name="status" type="string">
          <Notes>indicator of whether the model is stable, under
          construction, or under reconstruction</Notes>
        </Field>
        <Field name="reaction-count" type="int">
          <Notes>number of reactions in the model</Notes>
        </Field>
        <Field name="compound-count" type="int">
          <Notes>number of compounds in the model</Notes>
        </Field>
        <Field name="annotation-count" type="int">
          <Notes>number of features associated with one or more reactions in
          the model</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Source" keyType="string">
      <DisplayInfo theme="black">
        <RegionInfo name="Annotations" row="7" col="1" />
        <RegionInfo name="Models" row="9" col="3" />
        <RegionInfo name="" row="3" col="5" />
        <RegionInfo name="Subsystem" row="1" col="1" />
        <RegionInfo name="Alignments" row="1" col="3" />
      </DisplayInfo>
      <Notes>A source is a user or organization that is permitted to
      assign its own identifiers or to submit bioinformatic objects
      to the database.</Notes>
    </Entity>
    <Entity name="Role" keyType="string">
      <DisplayInfo theme="green" col="5" row="5">
        <RegionInfo name="" row="1" col="3" />
        <RegionInfo name="Subsystem" row="3" col="3" />
        <RegionInfo name="Chemistry" row="5" col="4" />
        <RegionInfo name="Models" col="5" row="7" />
        <RegionInfo name="Annotations" col="5" row="7" />
      </DisplayInfo>
      <Notes>A role describes a biological function that may be fulfilled
      by a feature. One of the main goals of the database is to assign
      features to roles. Most roles are effected by the construction of
      proteins. Some, however, deal with functional regulation and message
      transmission.</Notes>
      <Fields>
        <Field name="hypothetical" type="boolean">
          <Notes>TRUE if a role is hypothetical, else FALSE</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="id" in_result="1" />
      </FulltextIndexes>
    </Entity>
    <Entity name="Media" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Expression" row="7" col="6" />
        <RegionInfo name="Models" row="9" col="1" />
        <RegionInfo name="Experiment" row="7" col="3" />
      </DisplayInfo>
      <Notes>A media describes the chemical content of the solution in which cells
      are grown in an experiment or for the purposes of a model. The key is the
      common media name. The nature of the media is described by its relationship
      to its constituent compounds.</Notes>
      <Fields>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last modification to the media's
          definition</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>descriptive name of the media</Notes>
        </Field>
        <Field name="is-minimal" type="semi-boolean">
          <Notes>TRUE if this is a minimal media, else FALSE</Notes>
        </Field>
        <Field name="description" type="string">
          <Notes>description of the media condition</Notes>
        </Field>
		<Field name="solid" type="semi-boolean">
          <Notes>Whether the media is solid (True) or liquid (False).</Notes>
        </Field>
        <Field name="is-defined" type="semi-boolean">
          <Notes>TRUE if this media condition is defined (all components explicitly
          known)</Notes>
         </Field>
        <Field name="source-id" type="string">
          <Notes>The ID of the media used by the data source.</Notes>
        </Field>
        <Field name="type" type="string">
          <Notes>The general category of the media.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          media by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for a media
          by solidity.</Notes>
          <IndexFields>
            <IndexField name="solid" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for a media
          by whether it is defined.</Notes>
          <IndexFields>
            <IndexField name="is-defined" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Location" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" row="3" col="1" />
      </DisplayInfo>
      <Notes>A location is a region of the cell where reaction compounds
      originate from or are transported to (e.g. cell wall, extracellular,
      cytoplasm).</Notes>
      <Fields>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last modification to the
          compartment's definition</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>common name for the location</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID from the source of this location</Notes>
        </Field>
        <Field name="abbr" type="int">
          <Notes>an abbreviation (usually a single letter) for the
          location.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Compound" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Chemistry" row="1" col="2" />
        <RegionInfo name="Models" col="1" row="7" />
        <RegionInfo name="Experiment" row="7" col="5" />
      </DisplayInfo>
      <Notes>A compound is a chemical that participates in a reaction. Both
      ligands and reaction components are treated as compounds.</Notes>
      <Fields>
        <Field name="label" type="string">
          <Notes>primary name of the compound, for use in displaying
          reactions</Notes>
        </Field>
        <Field name="abbr" type="string">
          <Notes>shortened abbreviation for the compound name</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>common modeling ID of this compound</Notes>
        </Field>
        <Field name="ubiquitous" type="boolean">
          <Notes>TRUE if this compound is found in most reactions, else FALSE</Notes>
        </Field>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last modification to the
          compound definition</Notes>
        </Field>
        <Field name="mass" type="float">
          <Notes>pH-neutral atomic mass of the compound</Notes>
        </Field>
        <Field name="formula" type="string">
          <Notes>a pH-neutral formula for the compound</Notes>
        </Field>
        <Field name="charge" type="float">
          <Notes>computed charge of the compound in a pH-neutral
          solution</Notes>
        </Field>
        <Field name="deltaG" type="float">
          <Notes>the pH 7 reference Gibbs free-energy of formation for this
          compound as calculated by the group contribution method (units are
          kcal/mol)</Notes>
        </Field>
        <Field name="deltaG-error" type="float">
          <Notes>the uncertainty in the [b]deltaG[/b] value (units are
          kcal/mol)</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows searching for compounds by name.</Notes>
          <IndexFields>
            <IndexField name="label" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows retrieval by the common
          modeling ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Reaction" keyType="string">
      <DisplayInfo theme="navy">
        <RegionInfo name="Chemistry" row="3" col="2" />
        <RegionInfo name="Models" row="7" col="3" />
      </DisplayInfo>
      <Notes>A reaction is a chemical process that converts one set of
      compounds (substrate) to another set (products).</Notes>
      <Fields>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last modification to this reaction's
          definition</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>descriptive name of this reaction</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID of this reaction in the resource from which it was added</Notes>
        </Field>
        <Field name="abbr" type="string">
          <Notes>abbreviated name of this reaction</Notes>
        </Field>
        <Field name="direction" type="char">
          <Notes>direction of this reaction (&gt; for forward-only,
          &lt; for backward-only, = for bidirectional)</Notes>
        </Field>
        <Field name="deltaG" type="float">
          <Notes>Gibbs free-energy change for the reaction calculated using
          the group contribution method (units are kcal/mol)</Notes>
        </Field>
        <Field name="deltaG-error" type="float">
          <Notes>uncertainty in the [b]deltaG[/b] value (units are kcal/mol)</Notes>
        </Field>
        <Field name="thermodynamic-reversibility" type="string">
          <Notes>computed reversibility of this reaction in a
          pH-neutral environment</Notes>
        </Field>
        <Field name="default-protons" type="float">
          <Notes>number of protons absorbed by this reaction in a
          pH-neutral environment</Notes>
        </Field>
        <Field name="status" type="string">
          <Notes>string indicating additional information about
          this reaction, generally indicating whether the reaction
          is balanced and/or lumped</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows retrieval by the common
          modeling ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="LocalizedCompound" keyType="string">
      <DisplayInfo theme="navy" col="3" row="3"
        caption="Localized\nCompound">
        <RegionInfo name="Models" row="5" col="1" />
      </DisplayInfo>
      <Notes>This entity represents a compound occurring in a
      specific location. A reaction always involves localized
      compounds. If a reaction occurs entirely in a single
      location, it will frequently only be represented by the
      cytoplasmic versions of the compounds; however, a transport
      always uses specifically located compounds.</Notes>
    </Entity>
    <Entity name="Complex" keyType="string">
      <DisplayInfo theme="navy" col="3" row="3">
        <RegionInfo name="Chemistry" row="5" col="2" />
        <RegionInfo name="Models" row="9" col="5" />
      </DisplayInfo>
      <Notes>A complex is a set of chemical reactions that act in concert to
      effect a role.</Notes>
      <Fields>
        <Field name="name" type="string" relation="ComplexName">
          <Notes>name of this complex. Not all complexes have names.</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID of this complex in the source from which it was added.</Notes>
        </Field>
        <Field name="mod-date" type="date">
          <Notes>date and time of the last change to this complex's definition</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows retrieval by the common
          modeling ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Diagram" keyType="string">
      <DisplayInfo theme="ivory" col="5" row="3">
        <RegionInfo name="Chemistry" row="3" col="4" />
      </DisplayInfo>
      <Notes>A functional diagram describes a network of chemical
      reactions, often comprising a single subsystem.</Notes>
      <Fields>
        <Field name="name" type="text">
          <Notes>descriptive name of this diagram</Notes>
        </Field>
        <Field name="content" type="image" relation="DiagramContent">
          <Notes>content of the diagram, in PNG format</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Subsystem" keyType="string">
      <DisplayInfo theme="blue" col="7" row="3">
        <RegionInfo name="Subsystem" row="1" col="3" />
        <RegionInfo name="Chemistry" row="3" col="6" />
      </DisplayInfo>
      <Notes>A subsystem is a set of functional roles that have been annotated simultaneously (e.g.,
      the roles present in a specific pathway), with an associated subsystem spreadsheet
      which encodes the fids in each genome that implement the functional roles in the
      subsystem.</Notes>
      <Fields>
        <Field name="version" type="int">
          <Notes>version number for the subsystem. This value is
          incremented each time the subsystem is backed up.</Notes>
        </Field>
        <Field name="curator" type="string">
          <Notes>name of the person currently in charge of the
          subsystem</Notes>
        </Field>
        <Field name="notes" type="text">
          <Notes>descriptive notes about the subsystem</Notes>
        </Field>
        <Field name="description" type="text">
          <Notes>description of the subsystem's function in the
          cell</Notes>
        </Field>
        <Field name="usable" type="boolean">
          <Notes>TRUE if this is a usable subsystem, else FALSE. An
          unusable subsystem is one that is experimental or is of
          such low quality that it can negatively affect analysis.</Notes>
        </Field>
        <Field name="private" type="boolean">
          <Notes>TRUE if this is a private subsystem, else FALSE. A
          private subsystem has valid data, but is not considered ready
          for general distribution.</Notes>
        </Field>
        <Field name="cluster-based" type="boolean">
          <Notes>TRUE if this is a clustering-based subsystem, else
          FALSE. A clustering-based subsystem is one in which there is
          functional-coupling evidence that genes belong together, but
          we do not yet know what they do.</Notes>
        </Field>
        <Field name="experimental" type="boolean">
          <Notes>TRUE if this is an experimental subsystem, else FALSE.
          An experimental subsystem is designed for investigation and
          is not yet ready to be used in comparative analysis and
          annotation.</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="curator"
          in_result="1" />
        <FulltextIndex type="field" name="description" />
        <FulltextIndex type="field" name="id" in_result="1" />
        <FulltextIndex type="field" name="notes" />
      </FulltextIndexes>
    </Entity>
    <Entity name="SubsystemClass" keyType="string">
      <DisplayInfo theme="blue" caption="Subsystem Class">
        <RegionInfo name="Subsystem" row="1" col="5" />
        <RegionInfo name="Chemistry" row="5" col="6" />
      </DisplayInfo>
      <Notes>Subsystem classes impose a hierarchical organization on the
      subsystems.</Notes>
    </Entity>
    <Entity name="Publication" keyType="string">
      <DisplayInfo theme="green">
        <RegionInfo name="" row="1" col="1" />
        <RegionInfo name="Experiment" row="1" col="5" />
		<RegionInfo name="Expression_v2" row="1" col="2" />
      </DisplayInfo>
      <Notes>Experimenters attach publications to experiments and
      protocols. Annotators attach publications to ProteinSequences.
      The attached publications give an ID (usually a
      DOI or Pubmed ID),  a URL to the paper (when we have it), and a title
      (when we have it). Pubmed IDs are given unmodified. DOI IDs
      are prefixed with [b]doi:[/b], e.g. [i]doi:1002385[/i].</Notes>
      <Asides>The criteria we have used to gather protein sequence
      connections is a bit nonstandard.  We have sought to attach publications
      to ProteinSequences when the publication includes an expert asserting
      a belief or estimate of function.  The paper may not be the original
      characterization.  Further, it may not even discuss a sequence
      protein (much of the literature is very valuable, but reports
      work on proteins in strains that have not yet been sequenced).
      On the other hand, reports of sequencing regions of a chromosome
      (with no specific assertion of a clear function) should not be
      attached.</Asides>
      <Fields>
        <Field name="title" type="string">
          <Notes>title of the article, or (unknown) if the title is not known</Notes>
        </Field>
        <Field name="link" type="string">
          <Notes>URL of the article, DOI preferred</Notes>
        </Field>
        <Field name="pubdate" type="date">
          <Notes>publication date of the article</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="title"
          in_result="1" />
      </FulltextIndexes>
      <Indexes>
        <Index>
          <Notes>This index provides the ability to search by article
          title. It should only be used for LIKE-style searches, since
          the article titles are encoded together with the URLs.</Notes>
          <IndexFields>
            <IndexField name="title" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Variant" keyType="string">
      <DisplayInfo theme="blue" col="7" row="5">
        <RegionInfo name="Subsystem" row="3" col="5" />
      </DisplayInfo>
      <Notes>Each subsystem may include the designation of distinct
      variants.  Thus, there may be three closely-related, but
      distinguishable forms of histidine degradation.  Each form
      would be called a "variant", with an associated code, and all
      genomes implementing a specific variant can easily be accessed.</Notes>
      <Asides>The variant code is generally a number with zero or more
      decimal points, similar to what it done with software version numbers
      or legal outline numbers.</Asides>
      <Fields>
        <Field name="role-rule" type="text" relation="VariantRole">
          <Notes>a space-delimited list of role IDs, in alphabetical order,
          that represents a possible list of non-auxiliary roles applicable to
          this variant. The roles are identified by their abbreviations. A
          variant may have multiple role rules.</Notes>
        </Field>
        <Field name="code" type="string">
          <Notes>the variant code all by itself</Notes>
        </Field>
        <Field name="type" type="string">
          <Notes>variant type indicating the quality of the subsystem
          support. A type of "vacant" means that the subsystem
          does not appear to be implemented by the variant. A
          type of "incomplete" means that the subsystem appears to be
          missing many reactions. In all other cases, the type is
          "normal".</Notes>
        </Field>
        <Field name="comment" type="text">
          <Notes>commentary text about the variant</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="ProteinSequence" keyType="string">
      <DisplayInfo theme="green" col="3" row="7"
        caption="Protein Sequence">
        <RegionInfo name="" row="3" col="1" />
        <RegionInfo name="Chemistry" row="7" col="2" />
        <RegionInfo name="Annotations" row="5" col="1" />
        <RegionInfo name="Alignments" col="4" row="6" />
      </DisplayInfo>
      <Notes>We use the concept of ProteinSequence as an amino acid
      string with an associated MD5 value.  It is easy to access the
      set of Features that relate to a ProteinSequence.  While function
      is still associated with Features (and may be for some time),
      publications are associated with ProteinSequences (and the inferred
      impact on Features is through the relationship connecting
      ProteinSequences to Features).</Notes>
      <Fields>
        <Field name="sequence" type="text">
          <Notes>The sequence contains the letters corresponding to
          the protein's amino acids.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Family" keyType="string">
      <DisplayInfo theme="brown" col="4" row="11">
        <RegionInfo name="Annotations" row="5" col="5" />
      </DisplayInfo>
      <Notes>The Kbase will support the maintenance of protein families
      (as sets of Features with associated translations).  We are
      initially only supporting the notion of a family as composed of
      a set of isofunctional homologs.  That is, the families we
      initially support should be thought of as containing
      protein-encoding genes whose associated sequences all implement
      the same function (we do understand that the notion of "function"
      is somewhat ambiguous, so let us sweep this under the rug by
      calling a functional role a "primitive concept").

      We currently support families in which the members are
      protein sequences as well. Identical protein sequences
      as products of translating distinct genes may or may not
      have identical functions.  This may be justified, since
      in a very, very, very few cases identical proteins do, in
      fact, have distinct functions.</Notes>
      <Fields>
        <Field name="type" type="string">
          <Notes>type of protein family (e.g. FIGfam, equivalog)</Notes>
        </Field>
        <Field name="release" type="string">
          <Notes>release number / subtype of protein family</Notes>
        </Field>
        <Field name="family-function" type="text" relation="FamilyFunction">
          <Notes>optional free-form description of the family. For function-based
          families, this would be the functional role for the family
          members.</Notes>
        </Field>
        <Field name="alignment" type="text" relation="FamilyAlignment">
          <Notes>FASTA-formatted alignment of the family's protein
          sequences</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to find all families of
          a given type (e.g. all FIGfams).</Notes>
          <IndexFields>
            <IndexField name="type" order="ascending" />
            <IndexField name="release" order="ascending" />
            <IndexField name="id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="SSRow" keyType="string">
      <DisplayInfo theme="blue" col="7" row="7" caption="SS Row">
        <RegionInfo name="Subsystem" row="5" col="5" />
      </DisplayInfo>
      <Notes>An SSRow (that is, a row in a subsystem spreadsheet)
      represents a collection of functional roles present in the
      Features of a single Genome.  The roles are part of a designated
      subsystem, and the features associated with each role are included
      in the row. That is, a row amounts to an instance of a subsystem as
      it exists in a specific, designated genome.</Notes>
      <Asides>It is possible for a single subsystem to occur multiple times
      in a particular genome. If that is the case, then the subsystem will
      have a molecular machine for each occurrence. The region string used
      in forming the key insures that each row has a unique ID.</Asides>
      <Fields>
        <Field name="curated" type="boolean">
          <Notes>This flag is TRUE if the assignment of the molecular
          machine has been curated, and FALSE if it was made by an
          automated program.</Notes>
        </Field>
        <Field name="region" type="string">
          <Notes>Region in the genome for which the row is relevant.
          Normally, this is an empty string, indicating that the machine
          covers the whole genome. If a subsystem has multiple rows
          for a genome, this contains a location string describing the
          region occupied by this particular row.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Pairing" keyType="string">
      <DisplayInfo theme="brown">
        <RegionInfo name="Annotations" row="1" col="5" />
      </DisplayInfo>
      <Notes>A pairing indicates that two features are found
      close together in a genome. Not all possible pairings are stored in
      the database; only those that are considered for some reason to be
      significant for annotation purposes.The key of the pairing is the
      concatenation of the feature IDs in alphabetical order with an
      intervening colon.</Notes>
      <Asides>Theoretically, the pairing is unordered: (A,B) and (B,A)
      are the same pairing. It is frequently the case, however, that we
      need to refer to the "first" or "second" protein in the pairing.
      When this happens, the first one is always the protein with the
      alphabetically lesser key. The IsInPair relationship automatically
      shows the proteins in this order.</Asides>
    </Entity>
    <Entity name="Genome" keyType="string">
      <DisplayInfo theme="red">
        <RegionInfo name="Annotations" row="3" col="5" />
        <RegionInfo name="" row="5" col="5" />
        <RegionInfo name="Subsystem" row="7" col="5" />
        <RegionInfo name="Expression" row="7" col="2" />
        <RegionInfo name="Models" row="1" col="5" />
        <RegionInfo name="GenoPheno" row="1" col="4" />
        <RegionInfo name="Strain" row="5" col="1" />
        <RegionInfo name="Alignments" row="6" col="6" />
      </DisplayInfo>
      <Notes>The Kbase houses a large and growing set of genomes.  We
      often have multiple genomes that have identical DNA.  These usually
      have distinct gene calls and annotations, but not always.  We
      consider the Kbase to be a framework for managing hundreds of
      thousands of genomes and offering the tools needed to
      support compartive analysis on large sets of genomes,
      some of which are virtually identical.</Notes>
      <Asides>Each genome has an MD5 value computed from the DNA that is
      associated with the genome. Hence, it is easy to recognize when you
      have identical genomes, perhaps annotated by distinct groups.</Asides>
      <Fields>
        <Field name="pegs" type="int">
          <Notes>Number of protein encoding genes for this genome.</Notes>
        </Field>
        <Field name="rnas" type="int">
          <Notes>Number of RNA features found for this organism.</Notes>
        </Field>
        <Field name="scientific-name" type="string">
          <Notes>Full genus/species/strain name of the genome sequence.</Notes>
        </Field>
        <Field name="complete" type="boolean">
          <Notes>TRUE if the genome sequence is complete, else FALSE</Notes>
        </Field>
        <Field name="prokaryotic" type="boolean">
          <Notes>TRUE if this is a prokaryotic genome sequence, else FALSE</Notes>
        </Field>
        <Field name="dna-size" type="counter">
          <Notes>Number of base pairs in the genome sequence.</Notes>
        </Field>
        <Field name="contigs" type="int">
          <Notes>Number of contigs for this genome sequence.</Notes>
        </Field>
        <Field name="domain" type="string">
          <Notes>Domain for this organism (Archaea, Bacteria, Eukaryota,
          Virus, Plasmid, or Environmental Sample).</Notes>
        </Field>
        <Field name="genetic-code" type="int">
          <Notes>Genetic code number used for protein translation on most
          of this genome sequence's contigs.</Notes>
        </Field>
        <Field name="gc-content" type="float">
          <Notes>Percent GC content present in the genome sequence's
          DNA.</Notes>
        </Field>
        <Field name="phenotype" type="string" relation="GenomeSequencePhenotype">
          <Notes>zero or more strings describing phenotypic information
          about this genome sequence</Notes>
        </Field>
        <Field name="md5" type="string">
          <Notes>MD5 identifier describing the genome's DNA sequence</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>identifier assigned to this genome by the original
          source</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="scientific-name"
          in_result="1" />
        <FulltextIndex type="field" name="domain" />
        <FulltextIndex type="field" name="md5" in_result="1" />
        <FulltextIndex type="field" name="source-id"
          in_result="1" />
      </FulltextIndexes>
      <Indexes>
        <Index>
          <Notes>This index allows the applications to find all
          genome sequences in lexical order by name.</Notes>
          <IndexFields>
            <IndexField name="scientific-name" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the applications to find all
          genomes with the same genome sequence.</Notes>
          <IndexFields>
            <IndexField name="md5" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the applications to find all
          genomes by the genome ID from the core (source)
          database.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="CodonUsage" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" row="8" col="6" 
        			caption="Codon Usage" />
      </DisplayInfo>
      <Notes>This entity contains information about the codon usage
      frequency in a particular genome with respect to a particular
      type of analysis (e.g. high-expression genes, modal, mean, 
      etc.).</Notes>
      <Fields>
        <Field name="frequencies" type="long-string">
          <Notes>A packed-string representation of the codon usage
          frequencies. These are not global frequencies, but rather
          frequenicy of use relative to other codons that produce
          the same amino acid.</Notes>
        </Field>
        <Field name="genetic-code" type="int">
          <Notes>Genetic code used for these codons.</Notes>
        </Field>
        <Field name="type" type="string">
          <Notes>Type of frequency analysis: average, modal,
          high-expression, or non-native.</Notes>
        </Field>
        <Field name="subtype" type="string">
          <Notes>Specific nature of the codon usage with respect
          to the given type, generally indicative of how the
          frequencies were computed.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Annotation" keyType="string">
      <DisplayInfo col="3" row="11" theme="black">
        <RegionInfo name="Annotations" row="1" col="1" />
      </DisplayInfo>
      <Notes>An annotation is a comment attached to a feature.
      Annotations are used to track the history of a feature's
      functional assignments and any related issues. The key is
      the feature ID followed by a colon and a complemented ten-digit
      sequence number.</Notes>
      <Asides>The complemented sequence number causes the annotations to
      sort with the most recent one first.</Asides>
      <Fields>
        <Field name="annotator" type="string">
          <Notes>name of the annotator who made the comment</Notes>
        </Field>
        <Field name="comment" type="text">
          <Notes>text of the annotation</Notes>
        </Field>
        <Field name="annotation-time" type="date">
          <Notes>date and time at which the annotation was made</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Contig" keyType="string">
      <DisplayInfo theme="red">
        <RegionInfo name="" row="5" col="3" />
        <RegionInfo name="GenoPheno" row="3" col="2" />
      </DisplayInfo>
      <Notes>A contig is thought of as composing a part of the DNA
      associated with a specific genome.  It is represented as an ID
      (including the genome ID) and a ContigSequence. We do not think
      of strings of DNA from, say, a metgenomic sample as "contigs",
      since there is no associated genome (these would be considered
      ContigSequences). This use of the term "ContigSequence", rather
      than just "DNA sequence", may turn out to be a bad idea.  For now,
      you should just realize that a Contig has an associated
      genome, but a ContigSequence does not.</Notes>
      <Fields>
        <Field name="source-id" type="string">
          <Notes>ID of this contig from the core (source) database</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="source-id"
          in_result="1" />
        <FulltextIndex type="related_field" path="HasAsSequence">
          <UseField name="md5" field="from-link" />
        </FulltextIndex>
        <FulltextIndex type="related_field" path="IsComponentOf">
          <UseField name="genome" field="from-link" />
        </FulltextIndex>
      </FulltextIndexes>
      <Indexes>
        <Index>
          <Notes>This index allows you to find a contig by its ID from
          the core (source) database.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="ContigSequence" keyType="string">
      <DisplayInfo theme="red" caption="Contig\nSequence">
        <RegionInfo name="" row="7" col="3" />
        <RegionInfo name="Alignments" row="8" col="4" />
      </DisplayInfo>
      <Notes>ContigSequences are strings of DNA.  Contigs have an
      associated genome, but ContigSequences do not.  We can think
      of random samples of DNA as a set of ContigSequences. There
      are no length constraints imposed on ContigSequences -- they
      can be either very short or very long.  The basic unit of data
      that is moved to/from the database is the ContigChunk, from
      which ContigSequences are formed. The key of a ContigSequence
      is the sequence's MD5 identifier.</Notes>
      <Fields>
        <Field name="length" type="counter">
          <Notes>number of base pairs in the contig</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="ContigChunk" keyType="string">
      <DisplayInfo theme="red">
        <RegionInfo name="" row="9" col="3" caption="Contig Chunk" />
      </DisplayInfo>
      <Notes>ContigChunks are strings of DNA thought of as being a
      string in a 4-character alphabet with an associated ID.  We
      allow a broader alphabet that includes U (for RNA) and
      the standard ambiguity characters.</Notes>
      <Asides>The notion of ContigChunk was introduced to avoid
      transferring/manipulating huge contigs to access small substrings.
      A ContigSequence is formed by concatenating a set of one or more
      ContigChunks.  Thus, ContigChunks are the basic units moved from
      the database to memory.  Their existence should be hidden from
      users in most circumstances (users are expected to request
      substrings of ContigSequences, and the Kbase software locates
      the appropriate ContigChunks).

      The maximum length of a chunk is one million bases.
      The key is the contigID followed by a 7-digit ordinal number. So,
      the first sequence will have an ordinal of 0000000 and contain the base
      pairs from position 1 to position 1,000,000, the second will have an
      ordinal of 0000001 and contain the pairs from position 1,000,001 to
      2,000,000, and so forth. This will allow us to store 10 trillion
      base pairs per contig.</Asides>
      <Fields>
        <Field name="sequence" type="dna">
          <Notes>base pairs that make up this sequence</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="EcNumber" keyType="string">
      <DisplayInfo theme="navy" col="3" row="7" caption="EC\nNumber">
        <RegionInfo name="Chemistry" row="6" col="2" />
      </DisplayInfo>
      <Notes>EC numbers are assigned by the Enzyme Commission, and consist
      of four numbers separated by periods, each indicating a successively
      smaller cateogry of enzymes.</Notes>
      <Fields>
        <Field name="obsolete" type="boolean">
          <Notes>This boolean indicates when an EC number is obsolete.</Notes>
        </Field>
        <Field name="replacedby" type="string">
          <Notes>When an obsolete EC number is replaced with another EC number, this string will
          hold the name of the replacement EC number.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="SSCell" keyType="string">
      <DisplayInfo row="7" col="5" caption="SS Cell" theme="blue">
        <RegionInfo name="Subsystem" row="5" col="3" />
      </DisplayInfo>
      <Notes>An SSCell (SpreadSheet Cell) represents a role as it occurs
      in a subsystem spreadsheet row. The key is a colon-delimited triple
      containing an MD5 hash of the subsystem ID followed by a genome ID
      (with optional region string) and a role abbreviation.</Notes>
      <Asides>Features in the subsystem are assigned directly to the
      machine role.</Asides>
    </Entity>
    <Entity name="OTU" keyType="string">
      <DisplayInfo theme="red" caption="OTU">
        <RegionInfo name="" row="3" col="6" />
      </DisplayInfo>
      <Notes>An OTU (Organism Taxonomic Unit) is a named group of related
      genomes.</Notes>
      <Asides>Each OTU consists of genomes that use highly similar
      ribosomal small subunits. Two genomes are in the same set if they
      have a similarity of 97% or greater in subunits of length 1000 or
      more.</Asides>
    </Entity>
    <Entity name="PairSet" keyType="string">
      <DisplayInfo theme="brown" col="5" row="13" caption="Pair Set">
        <RegionInfo name="Annotations" row="3" col="6.5" />
      </DisplayInfo>
      <Notes>A PairSet is a precompute set of pairs or genes.  Each
      pair occurs close to one another of the chromosome.  We believe
      that all of the first members of the pairs correspond to one another
      (are quite similar), as do all of the second members of the pairs.
      These pairs (from prokaryotic genomes) offer one of the most
      powerful clues relating to uncharacterized genes/peroteins.</Notes>
      <Asides>The pairings for a particular evidence set will contain
      protein sequences that are significantly similar. In other words, if
      (A,B) and (X,Y) are both pairings in a single evidence set, then (A
      =~ X) and (B =~ Y) or (A =~ Y) and (B =~ X), depending on the value
      of the "inverted" attribute of the IsDeterminedBy relationship.
      Essentially, a pairing in its own right is unordered. If (A,B) is a
      pair, then so is (B,A). However, the evidence set maintains a
      correspondence between its pairs that _is_ ordered, because the
      constituent pairs must match. The direction in which a pair matches
      others in the set is an attribute of the relationship from the pairs
      to the sets.</Asides>
      <Fields>
        <Field name="score" type="int">
          <Notes>Score for this evidence set. The score indicates the
          number of significantly different genomes represented by the
          pairings.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Feature" keyType="string">
      <DisplayInfo theme="green">
        <RegionInfo name="Chemistry" col="4" row="7" />
        <RegionInfo name="" col="3" row="3" />
        <RegionInfo name="Subsystem" col="3" row="7" />
        <RegionInfo name="Annotations" col="3" row="3" />
        <RegionInfo name="Expression" col="2" row="2" />
        <RegionInfo name="Strain" row="1" col="1" />
        <RegionInfo name="Experiment" row="7" col="7" />
        <RegionInfo name="Models" row="3" col="5" />
		<RegionInfo name="Expression_v2" row="6" col="6" />
      </DisplayInfo>
      <Notes>A feature (sometimes also called a gene) is a part of a
      genome that is of special interest. Features may be spread across
      multiple DNA sequences (contigs) of a genome, but never across more
      than one genome. Each feature in the database has a unique
      ID that functions as its ID in this table. Normally a Feature is
      just a single contigous region on a contig. Features have types,
      and an appropriate choice of available types allows the support
      of protein-encoding genes, exons, RNA genes, binding sites,
      pathogenicity islands, or whatever.</Notes>
      <Fields>
        <Field name="feature-type" type="string">
          <Notes>Code indicating the type of this feature. Among the
          codes currently supported are "peg" for a protein encoding
          gene, "bs" for a binding site, "opr" for an operon, and so
          forth.</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID for this feature in its original source (core)
          database</Notes>
        </Field>
        <Field name="sequence-length" type="counter">
          <Notes>Number of base pairs in this feature.</Notes>
        </Field>
        <Field name="function" type="text">
          <Notes>Functional assignment for this feature. This will
          often indicate the feature's functional role or roles, and
          may also have comments.</Notes>
          <Asides>It will frequently be the case that a feature is
          assigned to a single role, and it is identical to the
          function. In some cases, a feature will have multiple roles,
          and all of them will be listed in the function field. In
          addition, the function may have comment text at the
          end.</Asides>
        </Field>
        <Field name="alias" type="string" relation="FeatureAlias">
          <Notes>alternative identifier for the feature. These are
          highly unstructured, and frequently non-unique.</Notes>
        </Field>
      </Fields>
      <FulltextIndexes>
        <FulltextIndex type="field" name="feature-type" />
        <FulltextIndex type="field" name="source-id" />
        <FulltextIndex type="field" name="function"
          in_result="1" />
        <FulltextIndex type="related_field" name="md5"
          path="Produces">
          <UseField name="md5" field="from_link" in_result="1" />
        </FulltextIndex>
        <FulltextIndex type="related_field" name="genome"
          path="IsOwnedBy Genome">
          <UseField name="genome_name" field="scientific-name"
            in_result="1" />
          <UseField name="source_genome" field="source-id" />
        </FulltextIndex>
      </FulltextIndexes>
      <Indexes>
        <Index>
          <Notes>This index is used to find features by their original database ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index is used to find features by their alias identifiers.</Notes>
          <IndexFields>
            <IndexField name="alias" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Scenario" keyType="int">
      <DisplayInfo theme="ivory" col="5" row="1">
        <RegionInfo name="Chemistry" row="1" col="4" />
      </DisplayInfo>
      <Notes>A scenario is a partial instance of a subsystem with a
      defined set of reactions. Each scenario converts input compounds to
      output compounds using reactions. The scenario may use all of the
      reactions controlled by a subsystem or only some, and may also
      incorporate additional reactions. Because scenario names are not
      unique, the actual scenario ID is a number.</Notes>
      <Fields>
        <Field name="common-name" type="string">
          <Notes>Common name of the scenario. The name, rather than the ID
          number, is usually displayed everywhere.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a scenario by name.</Notes>
          <IndexFields>
            <IndexField name="common-name" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="TaxonomicGrouping" keyType="counter">
      <DisplayInfo row="8" col="7" caption="Taxonomic\nGrouping"
        theme="red">
        <RegionInfo name="" row="7" col="5" />
        <RegionInfo name="GenoPheno" row="3" col="6" />
      </DisplayInfo>
      <Notes>We associate with most genomes a "taxonomy" based on
      the NCBI taxonomy. This includes, for each genome, a list of
      ever larger taxonomic groups. The groups are stored as
      instances of this entity, and chained together by the
      IsGroupFor relationship.</Notes>
      <Fields>
        <Field name="domain" type="boolean">
          <Notes>TRUE if this is a domain grouping, else FALSE.</Notes>
        </Field>
        <Field name="hidden" type="boolean">
          <Notes>TRUE if this is a hidden grouping, else FALSE. Hidden groupings
          are not typically shown in a lineage list.</Notes>
        </Field>
        <Field name="scientific-name" type="string">
          <Notes>Primary scientific name for this grouping. This is the name used
          when displaying a taxonomy.</Notes>
        </Field>
        <Field name="alias" type="string" relation="TaxonomicGroupingAlias">
          <Notes>Alternate name for this grouping. A grouping
          may have many alternate names. The scientific name should also
          be in this list.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to find a particular
          taxonomic grouping by name. Because the scientifc name is
          also an alias, there is no index on scientific name.</Notes>
          <IndexFields>
            <IndexField name="alias" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="ProbeSet" keyType="string">
      <DisplayInfo theme="cyan" caption="Probe Set">
        <RegionInfo name="Expression" row="5" col="2" />
      </DisplayInfo>
      <Notes>A probe set is a device containing multiple probe sequences for use
      in gene expression experiments.</Notes>
    </Entity>
    <Entity name="Experiment" keyType="string">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" row="7" col="4" />
      </DisplayInfo>
      <Notes>An experiment is a combination of conditions for which gene expression
      information is desired. The result of the experiment is a set of expression
      levels for features under the given conditions.</Notes>
      <Fields>
        <Field name="source" type="string">
          <Notes>Publication or lab relevant to this experiment.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="StudyExperiment" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="7" col="4"
          caption="Study Experiment" />
      </DisplayInfo>
      <Notes>An Experiment is a collection of observational units with one originator that are part of a specific study.  An experiment may be conducted at more than one location and in more than one season or year.</Notes>
      <Asides />
      <Fields>
        <Field name="source-name" type="string">
          <Notes>Name/ID by which the experiment is known at the source.  </Notes>
        </Field>
        <Field name="design" type="text">
          <Notes>Design of the experiment including the numbers and types of observational units, traits, replicates, sampling plan, and analysis that are planned.</Notes>
        </Field>
        <Field name="originator" type="string">
          <Notes>Name of the individual or program that are the originators of the experiment.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Locality" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="5" col="6" caption="Locality" />
      </DisplayInfo>
      <Notes>A locality is a geographic location.</Notes>
      <Asides />
      <Fields>
        <Field name="source-name" type="string">
          <Notes>Name or description of the location used as a collection site.</Notes>
        </Field>
        <Field name="city" type="string">
          <Notes>City of the collecting site.</Notes>
        </Field>
        <Field name="state" type="string">
          <Notes>State or province of the collecting site.</Notes>
        </Field>
        <Field name="country" type="string">
          <Notes>Country of the collecting site.</Notes>
        </Field>
        <Field name="origcty" type="string">
          <Notes>3-letter ISO 3166-1 extended country code for the country of origin.</Notes>
        </Field>
        <Field name="elevation" type="int">
          <Notes>Elevation of the collecting site, expressed in meters above sea level.  Negative values are allowed.</Notes>
        </Field>
        <Field name="latitude" type="int">
          <Notes>Latitude of the collecting site, recorded as a decimal number.  North latitudes are positive values and south latitudes are negative numbers.</Notes>
        </Field>
        <Field name="longitude" type="int">
          <Notes>Longitude of the collecting site, recorded as a decimal number.  West longitudes are positive values and east longitudes are negative numbers.</Notes>
        </Field>
        <Field name="lo-accession" type="string">
          <Notes>gazeteer ontology term ID</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="ObservationalUnit" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="5" col="4"
          caption="Observational Unit" />
      </DisplayInfo>
      <Notes>An ObservationalUnit is an individual plant that 1) is part of an experiment or study, 2) has measured traits, and 3) is assayed for the purpose of determining alleles.  </Notes>
      <Asides>It is assumed that each observational unit belongs to only one experiment.  If the plant later becomes part of another experiment, a new observational unit record and ID will be created. </Asides>
      <Fields>
        <Field name="source-name" type="string">
          <Notes>Name/ID by which the observational unit may be known by the originator and is used in queries.</Notes>
        </Field>
        <Field name="source-name2" type="string" relation="ObservationalUnitName2">
          <Notes>Secondary name/ID by which the observational unit may be known and is queried.</Notes>
        </Field>
        <Field name="plant-id" type="string">
          <Notes>ID of the plant that was tested to produce this
          observational unit. Observational units with the same plant
          ID are different assays of a single physical organism.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Trait" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="5" col="2" caption="Trait" />
      </DisplayInfo>
      <Notes>A Trait is a phenotypic quality that can be measured or observed for an observational unit.  Examples include height, sugar content, color, or cold tolerance.</Notes>
      <Asides>It is assumed that each observational unit belongs to only one experiment.  If the plant later becomes part of another experiment, a new observational unit record and ID will be created. </Asides>
      <Fields>
        <Field name="trait-name" type="string">
          <Notes>Text name or description of the trait</Notes>
        </Field>
        <Field name="unit-of-measure" type="string">
          <Notes>The units of measure used when determining this trait.  If multiple units of measure are applicable, each has its own row in the database.  </Notes>
        </Field>
        <Field name="TO-ID" type="string">
          <Notes>Trait Ontology term ID (http://www.gramene.org/plant-ontology/)</Notes>
        </Field>
        <Field name="protocol" type="text">
          <Notes>A thorough description of how the trait was collected, and if a rating, the minimum and maximum values</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Assay" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="9" col="4" caption="Assay" />
      </DisplayInfo>
      <Notes>An assay is an experimental design for determining alleles at specific chromosome positions.</Notes>
      <Fields>
        <Field name="source-id" type="string">
          <Notes>identifier for this assay in the original (source) database</Notes>
        </Field>
        <Field name="assay-type" type="string">
          <Notes>Text description of the type of assay (e.g., SNP, length, sequence, categorical, array, short read, SSR marker, AFLP marker)</Notes>
        </Field>
        <Field name="assay-type-id" type="string">
          <Notes>source ID associated with the assay type (informational)</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="AlleleFrequency" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" row="1" col="2"
          caption="Allele Frequency" />
      </DisplayInfo>
      <Notes>An allele frequency represents a summary of the major and minor allele frequencies for a position on a chromosome.</Notes>
      <Asides />
      <Fields>
        <Field name="source-id" type="string">
          <Notes>identifier for this allele in the original (source) database</Notes>
        </Field>
        <Field name="position" type="int">
          <Notes>Specific position on the contig where the allele occurs</Notes>
        </Field>
        <Field name="minor-AF" type="float">
          <Notes>Minor allele frequency.  Floating point number from 0.0 to 0.5.</Notes>
        </Field>
        <Field name="minor-allele" type="char">
          <Notes>Text letter representation of the minor allele. Valid values are A, C, G, and T.</Notes>
        </Field>
        <Field name="major-AF" type="float">
          <Notes>Major allele frequency.  Floating point number less than or equal to 1.0.</Notes>
        </Field>
        <Field name="major-allele" type="char">
          <Notes>Text letter representation of the major allele. Valid values are A, C, G, and T.</Notes>
        </Field>
        <Field name="obs-unit-count" type="int">
          <Notes>Number of observational units used to compute the allele frequencies. Indicates
          the quality of the analysis.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Attribute" keyType="string">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" row="5" col="6" />
      </DisplayInfo>
      <Notes>An attribute describes a category of condition or characteristic for
      an experiment. The goals of the experiment can be inferred from its values
      for all the attributes of interest.</Notes>
      <Fields>
        <Field name="description" type="text">
          <Notes>Descriptive text indicating the nature and use of this attribute.</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="CoregulatedSet" keyType="string">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" row="2" col="4" />
      </DisplayInfo>
      <Notes>We need to represent sets of genes that are coregulated via
      some regulatory mechanism.  In particular, we wish to represent
      genes that are coregulated using transcription binding sites and
      corresponding transcription regulatory proteins. We represent a
      coregulated set (which may, or may not, be considered a regulon)
      using CoregulatedSet.</Notes>
      <Fields>
        <Field name="source-id" type="string">
          <Notes>original ID of this coregulated set in the source (core)
          database</Notes>
        </Field>
        <Field name="binding-location" type="int"
          relation="CoregulatedSetBinding">
          <Notes>binding location for this set's transcription factor;
          there may be none of these or there may be more than one</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="AtomicRegulon" keyType="string">
      <DisplayInfo theme="cyan" caption="Atomic\nRegulon">
        <RegionInfo name="Expression" row="9" col="2" />
      </DisplayInfo>
      <Notes>An atomic regulon is an indivisible group of coregulated
      features on a single genome. Atomic regulons are constructed so
      that a given feature can only belong to one. Because of this, the
      expression levels for atomic regulons represent in some sense the
      state of a cell.</Notes>
      <Asides>An atomicRegulon is a set of protein-encoding genes that
      are believed to have identical expression profiles (i.e.,
      they will all be expressed or none will be expressed in the
      vast majority of conditions).  These are sometimes referred
      to as "atomic regulons".  Note that there are more common
      notions of "coregulated set of genes" based on the notion
      that a single regulatory mechanism impacts an entire set of
      genes. Since multiple other mechanisms may impact
      overlapping sets, the genes impacted by a regulatory
      mechanism need not all share the same expression profile.
      We use a distinct notion (CoregulatedSet) to reference sets
      of genes impacted by a single regulatory mechanism (i.e.,
      by a single transcription regulator).

      The ID of an atomic regulon is the genome ID, a colon, and the
      atomic regulon sequence number.</Asides>
    </Entity>
    <Entity name="Alignment" keyType="string">
      <DisplayInfo theme="purple" caption="Alignment">
        <RegionInfo name="Alignments" row="3" col="2" />
      </DisplayInfo>
      <Notes>An alignment arranges a group of sequences so that they
      match. Each alignment is associated with a phylogenetic tree that
      describes how the sequences developed and their evolutionary
      distance.</Notes>
      <Asides>The Kbase will maintain a set of alignments and associated
      trees.  The majority of these will be based on protein sequences.
      We will not have a comprehensive set, but we will have tens of
      thousands of such alignments, and we view them as an imporant
      resource to support annotation.

      The alignments/trees will include data on the tools and parameters
      used to construct them.

      Access to the underlying sequences and trees in a form convenient to existing
      tools will be supported.</Asides>
      <Fields>
        <Field name="n-rows" type="int">
          <Notes>number of rows in the alignment</Notes>
        </Field>
        <Field name="n-cols" type="int">
          <Notes>number of columns in the alignment</Notes>
        </Field>
        <Field name="status" type="string">
          <Notes>status of the alignment, currently either [i]active[/i],
          [i]superseded[/i], or [i]bad[/i]</Notes>
        </Field>
        <Field name="is-concatenation" type="boolean">
          <Notes>TRUE if the rows of the alignment map to multiple
          sequences, FALSE if they map to single sequences</Notes>
        </Field>
        <Field name="sequence-type" type="string">
          <Notes>type of sequence being aligned, currently either
          [i]Protein[/i], [i]DNA[/i], [i]RNA[/i], or [i]Mixed[/i]</Notes>
        </Field>
        <Field name="timestamp" type="date">
          <Notes>date and time the alignment was loaded</Notes>
        </Field>
        <Field name="method" type="string">
          <Notes>name of the primary software package or script used
          to construct the alignment</Notes>
        </Field>
        <Field name="parameters" type="long-string">
          <Notes>non-default parameters used as input to the software
	  package or script indicated in the method attribute</Notes>
        </Field>
        <Field name="protocol" type="text">
          <Notes>description of the steps taken to construct the alignment,
          or a reference to an external pipeline</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID of this alignment in the source database</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="AlignmentAttribute" keyType="string">
      <DisplayInfo theme="purple" caption="Alignment\nAttribute">
        <RegionInfo name="Alignments" row="1" col="1" />
      </DisplayInfo>
      <Notes>This entity represents an attribute type that can
      be assigned to an alignment. The attribute
      values are stored in the relationships to the target. The
      key is the attribute name.</Notes>
    </Entity>
    <Entity name="TreeNodeAttribute" keyType="string">
      <DisplayInfo theme="purple" caption="Tree Node\nAttribute">
        <RegionInfo name="Alignments" row="1" col="5" />
      </DisplayInfo>
      <Notes>This entity represents an attribute type that can
      be assigned to a node. The attribute
      values are stored in the relationships to the target. The
      key is the attribute name.</Notes>
    </Entity>
    <Entity name="TreeAttribute" keyType="string">
      <DisplayInfo theme="purple" caption="Tree\nAttribute">
        <RegionInfo name="Alignments" row="1" col="4" />
      </DisplayInfo>
      <Notes>This entity represents an attribute type that can
      be assigned to a tree. The attribute
      values are stored in the relationships to the target. The
      key is the attribute name.</Notes>
    </Entity>
    <Entity name="AlignmentRow" keyType="string">
      <DisplayInfo theme="purple" caption="Alignment\nRow">
        <RegionInfo name="Alignments" row="7" col="2" />
      </DisplayInfo>
      <Notes>This entity represents a single row of an alignment.
      In general, this corresponds to a sequence, but in a
      concatenated alignment multiple sequences may be represented
      here.</Notes>
      <Fields>
        <Field name="row-number" type="int">
          <Notes>1-based ordinal number of this row in the alignment</Notes>
        </Field>
        <Field name="row-id" type="string">
          <Notes>identifier for this row in the FASTA file for the alignment</Notes>
        </Field>
        <Field name="row-description" type="string">
          <Notes>description of this row in the FASTA file for the alignment</Notes>
        </Field>
        <Field name="n-components" type="int">
          <Notes>number of components that make up this alignment
          row; for a single-sequence alignment this is always "1"</Notes>
        </Field>
        <Field name="beg-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          sequence row begins</Notes>
        </Field>
        <Field name="end-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          sequence row ends</Notes>
        </Field>
        <Field name="md5-of-ungapped-sequence" type="string">
          <Notes>the MD5 of this row's sequence after gaps have been
          removed; for DNA and RNA sequences, the [b]U[/b] codes are also
          normalized to [b]T[/b] before the MD5 is computed</Notes>
        </Field>
        <Field name="sequence" type="text">
          <Notes>sequence for this alignment row (with indels)</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Tree" keyType="string">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" row="3" col="4" />
      </DisplayInfo>
      <Notes>A tree describes how the sequences in an alignment relate
      to each other. Most trees are phylogenetic, but some may be based on
      taxonomy or gene content.</Notes>
      <Fields>
        <Field name="status" type="string">
          <Notes>status of the tree, currently either [i]active[/i],
          [i]superseded[/i], or [i]bad[/i]</Notes>
        </Field>
        <Field name="data-type" type="string">
          <Notes>type of data the tree was built from, usually
          [i]sequence_alignment[/i]</Notes>
        </Field>
        <Field name="timestamp" type="date">
          <Notes>date and time the tree was loaded</Notes>
        </Field>
        <Field name="method" type="string">
          <Notes>name of the primary software package or script used
          to construct the tree</Notes>
        </Field>
        <Field name="parameters" type="long-string">
          <Notes>non-default parameters used as input to the software
	  package or script indicated in the method attribute</Notes>
        </Field>
        <Field name="protocol" type="text">
          <Notes>description of the steps taken to construct the tree,
          or a reference to an external pipeline</Notes>
        </Field>
        <Field name="source-id" type="string">
          <Notes>ID of this tree in the source database</Notes>
        </Field>
        <Field name="newick" type="text">
          <Notes>NEWICK format string containing the structure
          of the tree</Notes>
        </Field>
      </Fields>
    </Entity>
    <Entity name="Strain" keyType="string">
      <DisplayInfo theme="tan">
        <RegionInfo name="Experiment" col="1" row="3" />
        <RegionInfo name="Strain" col="1" row="3" />
		<RegionInfo name="Expression_v2" row="4" col="2" />
      </DisplayInfo>
      <Notes>This entity represents an organism derived from a genome or
      another organism with one or more modifications to the organism's
      genome.</Notes>
      <Fields>
        <Field name="name" type="string">
          <Notes>The common or laboratory name of the strain, e.g. DH5a or
          JMP1004.</Notes>
        </Field>
        <Field name="description" type="string">
          <Notes>A description of the strain, e.g. knockout/modification
          methods, resulting phenotypes, etc.</Notes>
        </Field>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the strain used by the data source.</Notes>
        </Field>
        <Field name="aggregateData" type="semi-boolean">
          <Notes>Denotes whether this entity represents a physical strain
          (False) or aggregate data calculated from one or more strains
          (True).</Notes>
        </Field>
        <Field name="wildtype" type="semi-boolean">
          <Notes>Denotes this strain is presumably identical to the parent
          genome.</Notes>
        </Field>
        <Field name="referenceStrain" type="semi-boolean">
          <Notes>Denotes whether this strain is a reference strain; e.g. it
          is identical to the genome it's related to (True) or not (False). 
          In contrast to wildtype, a referenceStrain is abstract and does 
          not physically exist and is used for data that refers to a genome
          but not a particular strain. There should only exist one reference
          strain per genome and all reference strains are wildtype.
          </Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          strain by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for a strain
          by whether it is a wildtype strain.</Notes>
          <IndexFields>
            <IndexField name="wildtype" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for a strain
          by whether it represents aggregate data.</Notes>
          <IndexFields>
            <IndexField name="aggregateData" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="ExperimentalUnit" keyType="string">
      <DisplayInfo theme="gray" caption="Experimental\nUnit">
        <RegionInfo name="Experiment" col="3" row="3" />
		<RegionInfo name="Expression_v2" row="5" col="1" />
      </DisplayInfo>
      <Notes>An ExperimentalUnit is a subset of an experiment consisting of
      a Strain, an Environment, and one or more Measurements on that
      strain in the specified environment. ExperimentalUnits belong to a
      single experiment.</Notes>
      <Fields>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the experimental unit used by the data source.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          experimental unit by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="ExperimentalUnitGroup" keyType="string">
      <DisplayInfo theme="gray" caption="Experimental\nUnitGroup">
      	<RegionInfo name="Experiment" col="1" row="7" />
      </DisplayInfo>
      <Notes>An ExperimentalUnitGroup allows for grouping related experimental units
      and their measurements - for instance measurements that were in the same plate.
      </Notes>
      <Fields>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the experimental unit group used by the data source.</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>The name of this group, if any.</Notes>
        </Field>
        <Field name="comments" type="string">
          <Notes>Any comments about this group.</Notes>
        </Field>
        <Field name="groupType" type="string">
          <Notes>The type of this grouping, for example '24 well plate', '96 well plate',
          '384 well plate', 'microarray'.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          experimental unit group by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="TimeSeries" keyType="string">
      <DisplayInfo theme="gray" caption="TimeSeries">
      	<RegionInfo name="Experiment" col="1" row="5" />
      </DisplayInfo>
      <Notes>A TimeSeries provides a means to specify a series of experimental data
      over time by ordering multiple ExperimentalUnits.
      </Notes>
      <Fields>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the time series used by the data source.</Notes>
        </Field>
        <Field name="name" type="string">
          <Notes>The name of this time series, if any.</Notes>
        </Field>
        <Field name="comments" type="string">
          <Notes>Any comments regarding this time series.</Notes>
        </Field>
        <Field name="timeUnits" type="string">
          <Notes>The units of time for this time series, e.g. 'seconds', 'hours', or more 
          abstractly, 'number of times culture grown to saturation.'</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          time series by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Measurement" keyType="string">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" col="5" row="3" />
      </DisplayInfo>
      <Notes>A Measurement is a value generated by performing a protocol to
      evaluate a value on an ExperimentalUnit - e.g. a strain in an
      environment.</Notes>
      <Fields>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the measurement used by the data source.</Notes>
        </Field>
        <Field name="value" type="float" null="1">
          <Notes>The value of the measurement.</Notes>
        </Field>
        <Field name="mean" type="float" null="1">
          <Notes>The mean of multiple replicates if they are included in the
          measurement.</Notes>
        </Field>
        <Field name="median" type="float" null="1">
          <Notes>The median of multiple replicates if they are included in
          the measurement.</Notes>
        </Field>
        <Field name="stddev" type="float" null="1">
          <Notes>The standard deviation of multiple replicates if they are
          included in the measurement.</Notes>
        </Field>
        <Field name="N" type="int" null="1">
          <Notes>The number of replicates if they are included in the
          measurement.</Notes>
        </Field>
        <Field name="p-value" type="float" null="1">
          <Notes>The p-value of multiple replicates if they are included in
          the measurement. The exact meaning of the p-value is specified in
          the Phenotype object for this measurement.</Notes>
        </Field>
        <Field name="Z-score" type="float" null="1">
          <Notes>The Z-score of multiple replicates if they are included in
          the measurement. The exact meaning of the p-value is specified in
          the Phenotype object for this measurement.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          measurement by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="MeasurementDescription" keyType="string">
      <DisplayInfo theme="gray" caption="Measurement\nDescription">
        <RegionInfo name="Experiment" col="7" row="3" />
      </DisplayInfo>
      <Notes>A MeasurementDescription provides information about a 
      measurement value.</Notes>
      <Fields>
        <Field name="name" type="string">
          <Notes>The name of the measurement.</Notes>
        </Field>
        <Field name="description" type="text">
          <Notes>The description of the measurement, how it is
          measured, and what the measurement statistics mean.</Notes>
        </Field>
        <Field name="unitOfMeasure" type="string">
          <Notes>The units of the measurement.</Notes>
        </Field>
        <Field name="category" type="string">
          <Notes>The category the measurement fits into, for example
          phenotype, experimental input, environment.</Notes>
        </Field>
		<Field name="source-id" type="string" unique="1">
          <Notes>The ID of the measurement description used by the data source.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          measurement description by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="ExperimentMeta" keyType="string">
      <DisplayInfo theme="gray" caption="ExperimentMeta">
        <RegionInfo name="Experiment" col="3" row="1" />
		<RegionInfo name="Expression_v2" row="2" col="1" />
      </DisplayInfo>
      <Notes>An Experiment consists of (potentially) multiple
      strains, environments, and measurements on
      those strains and environments.</Notes>
      <Fields>
		<Field name="title" type="string">
          <Notes> Title of the experiment.</Notes>
        </Field>
        <Field name="description" type="text">
          <Notes> Description of the experiment including the experimental
          plan, general results, and conclusions, if possible.</Notes>
        </Field>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the experiment used by the data source.</Notes>
        </Field>
        <Field name="startDate" type="date">
          <Notes>The date this experiment was started.</Notes>
        </Field>
        <Field name="comments" type="text">
          <Notes>Any data describing the experiment that is not covered by
          the description field.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          experiment meta object by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Person" keyType="string">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" col="1" row="1" />
		<RegionInfo name="Expression_v2" row="1" col="5" />
      </DisplayInfo>
      <Notes>A person represents a human affiliated in some way with Kbase.</Notes>
      <Fields>
        <Field name="firstName" type="string">
          <Notes>The given name of the person.</Notes>
        </Field>
        <Field name="lastName" type="string">
          <Notes>The surname of the person.</Notes>
        </Field>
        <Field name="contactEmail" type="string">
          <Notes>Email address of the person.</Notes>
        </Field>
        <Field name="institution" type="string">
          <Notes>The institution where the person works.</Notes>
        </Field>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the person used by the data source.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          person by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" unique="1"/>
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for a person
          by name.</Notes>
          <IndexFields>
            <IndexField name="lastName" order="ascending" />
            <IndexField name="firstName" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Protocol" keyType="string">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" col="7" row="1" />
		<RegionInfo name="Expression_v2" row="5" col="6" />
      </DisplayInfo>
      <Notes>A Protocol is a step by step set of instructions for
      performing a part of an experiment.</Notes>
      <Fields>
        <Field name="name" type="string">
          <Notes>The name of the protocol.</Notes>
        </Field>
        <Field name="description" type="text">
          <Notes>The step by step instructions for performing the experiment,
          including measurement details, materials, and equipment. A
          researcher should be able to reproduce the experimental results
          with this information.</Notes>
        </Field>
		<Field name="source-id" type="string" unique="1">
          <Notes>The ID of the protocol used by the data source.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for a
          protocol by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending"/>
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Environment" keyType="string">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" col="5" row="3" />
		<RegionInfo name="Expression_v2" row="6" col="2" />
      </DisplayInfo>
      <Notes>An Environment is a set of conditions for microbial growth,
      including temperature, aerobicity, media, and supplementary
      conditions.</Notes>
      <Fields>
        <Field name="temperature" type="float">
          <Notes>The temperature in Kelvin.</Notes>
        </Field>
		<Field name="description" type="string">
          <Notes>A description of the environment.</Notes>
        </Field>
        <Field name="oxygenConcentration" type="float">
          <Notes>The oxygen concentration in the environment in Molar (mol/L).
          A value of -1 indicates that there is oxygen in the environment 
          but the concentration is not known, (e.g. an open air shake flask 
          experiment).</Notes>
        </Field>
        <Field name="pH" type="float" null="1">
          <Notes>The pH of the media used in the environment.</Notes>
        </Field>
        <Field name="source-id" type="string" unique="1">
          <Notes>The ID of the environment used by the data source.</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index allows the user to search for an
          environment by source ID.</Notes>
          <IndexFields>
            <IndexField name="source-id" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for an environment
          by temperature.</Notes>
          <IndexFields>
            <IndexField name="temperature" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for an environment
          by pH.</Notes>
          <IndexFields>
            <IndexField name="pH" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index allows the user to search for an environment
          by oxygen concentration.</Notes>
          <IndexFields>
            <IndexField name="oxygenConcentration" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Entity>
    <Entity name="Parameter" keyType="string">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" col="5" row="5" />
      </DisplayInfo>
      <Notes>A parameter is the name of some quantity that has a value. 
      </Notes>
      <Fields>
        <Field name="id" type="string" unique='1'>
          <Notes>The name of the parameter.</Notes>
        </Field>
      </Fields>
    </Entity>
	<Entity name="Series" keyType="string">
	<DisplayInfo theme="cyan">
		<RegionInfo name="Expression_v2" row="2" col="4" />
	</DisplayInfo> 		  
		<Notes>A series refers to a group of samples for expression data.</Notes>
		<Asides>This often times will map to a GEO Series aka GSE#.</Asides>
		<Fields>
			<Field name="title" type="long-string">
				<Notes>free text title of the series</Notes>
			</Field>
			<Field name="summary" type="long-string">
				<Notes>free text summary of the series</Notes>
			</Field>
			<Field name="design" type="long-string">
				<Notes>free text design of the series</Notes>
			</Field>
			<Field name="externalSourceId" type="string">
				<Notes>The externalSourceId gives users potentially an easy way to find the data of interest (ex:GSE2365).
					This will keep them from having to do problematic likes on the source-id field.</Notes>
			</Field>
			<Field name="kbaseSubmissionDate" type="date">
				<Notes>date of submission (to Kbase)</Notes>
			</Field>
			<Field name="externalSourceDate" type="date">
				<Notes>date that may exist in the external source metadata (could be to GEO, M3D etc...)</Notes>
			</Field>
			<Field name="source-id" type="string">
				<Notes>The ID of the environment used by the data source.</Notes>
			</Field>
		</Fields>
		<FulltextIndexes>
			<FulltextIndex type="field" name="title"
				in_result="1" />
			<FulltextIndex type="field" name="summary"
				in_result="1" />
			<FulltextIndex type="field" name="design"
				in_result="1" />
		</FulltextIndexes>
		<Indexes>
			<Index>
			<Notes>This index provides the ability to search by 
				title. It should only be used for LIKE-style searches.</Notes>
				<IndexFields>
					<IndexField name="title" order="ascending" />
				</IndexFields>
			</Index>
			<Index>
			<Notes>This index allows retrieval by the external source id.</Notes>
				<IndexFields>
					<IndexField name="externalSourceId" order="ascending" />
				</IndexFields>
			</Index>				
			<Index>
				<Notes>This index allows retrieval by the source id.</Notes>
				<IndexFields>
					<IndexField name="source-id" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>
	</Entity>
	<Entity name="Platform" keyType="string">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" row="2" col="2" />
		</DisplayInfo>
		<Notes>Platform that the expression sample/experiment was run on.</Notes>
		<Asides>This often times will map to a GEO Platform (aka GPL).</Asides>
		<Fields>
			<Field name="title" type="long-string">
				<Notes>free text title of the comparison</Notes>
			</Field>
			<Field name="externalSourceId" type="string">
				<Notes>The externalSourceId gives users potentially an easy way to find the data of interest (ex:GPL514).
				This will keep them from having to do problematic likes on the source-id field.</Notes>
			</Field>
			<Field name="technology" type="long-string">
				<Notes>Ideally enumerated values, but may have to make this free text (spotted DNA/cDNA, spotted oligonucleotide, in situ oligonucleotide, antibody, tissue, SARST, RT-PCR, or MPSS).</Notes>
			</Field>
			<Field name="type" type="string">
				<Notes>Enumerated Microarray, RNA-Seq, qPCR</Notes>
			</Field>
			<Field name="source-id" type="string">
				<Notes>The ID of the environment used by the data source.</Notes>
			</Field>
		</Fields>
		<FulltextIndexes>
			<FulltextIndex type="field" name="title" in_result="1" />
		</FulltextIndexes>
		<Indexes>
			<Index>
				<Notes>This index allows retrieval by the external source id.</Notes>
				<IndexFields>
					<IndexField name="externalSourceId" order="ascending" />
				</IndexFields>
			</Index>
			<Index>
				<Notes>This index allows retrieval by the source id.</Notes>
				<IndexFields>
					<IndexField name="source-id" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>	
	</Entity>
	<Entity name="Sample" keyType="string">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" row="4" col="4" />
		</DisplayInfo>
		<Notes>A sample is an experiment.  
				In intensity experiment situations the sample will map 1 to 1 to the GSM.  
				In this case there will be corresponding Log2Level data.
			</Notes>
		<Asides>This often times will map to a GEO GSM.</Asides>
		<Fields>
			<Field name="title" type="long-string">
				<Notes>free text title of the sample</Notes>
			</Field>
			<Field name="dataSource" type="string">
			<Notes>The Data Source will be a way to identify where the data came from.  Examples might be : GEO, SEED Expression Pipeline, Enigma, M3D</Notes>
			</Field>
			<Field name="externalSourceId" type="string">
				<Notes>The externalSourceId gives users potentially an easy way to find the data of interest (ex:GSM9514).
				This will keep them from having to do problematic likes on the source-id field.</Notes>
			</Field>
			<Field name="description" type="long-string">
				<Notes>Free-text descibing the experiment.</Notes>
			</Field>
			<Field name="molecule" type="string">
				<Notes>Enumerated field (total RNA, polyA RNA, cytoplasmic RNA, nuclear RNA, genomic DNA).</Notes>
			</Field>
			<Field name="type" type="string">
				<Notes>Enumerated Microarray, RNA-Seq, qPCR</Notes>
			</Field>			
			<Field name="kbaseSubmissionDate" type="date">
				<Notes>date of submission to Kbase</Notes>
			</Field>
			<Field name="externalSourceDate" type="date">
				<Notes>date that may exist in the external source metadata (could be to GEO, M3D etc...)</Notes>
			</Field>
			<Field name="custom" type="semi-boolean">
			  <Notes>A flag to keep track if this series was generated by custom operations (averaging or comparison)</Notes>
			</Field>
			<Field name="originalLog2Median" type="float" null="1">
			  <Notes>The Original Median of the sample in log2space.  If null means the original median was not able to be determined.</Notes>
			</Field>
			<Field name="source-id" type="string">
				<Notes>The ID of the environment used by the data source.</Notes>
			</Field>
		</Fields>
		<FulltextIndexes>
			<FulltextIndex type="field" name="title" in_result="1" />
			<FulltextIndex type="field" name="description" in_result="1" />
			<FulltextIndex type="field" name="dataSource" in_result="1" />
		</FulltextIndexes>
		<Indexes>
			<Index>
				<Notes>Allows for quick retrieval of certain molecule types.</Notes>
				<IndexFields>
					<IndexField name="molecule" order="ascending" />
				</IndexFields>
			</Index>
			<Index>
				<Notes>This index allows retrieval by the source id.</Notes>
				<IndexFields>
					<IndexField name="source-id" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>	
	</Entity>
	<Entity name="Log2Level" keyType="string">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" row="6" col="4" />
		</DisplayInfo>
		<Notes>Log2level is the normalized log2 of the sample's intensity/count for a feature.  All values are put into log2 space and the median for the levels for a given sample is set to zero.</Notes>
		<Fields>
			<Field name="log2Level" type="float">
				<Notes>Log2Level is the normalized log2 of the sample's intensity/count for a feature.</Notes>
			</Field>
			<Field name="stdDev" type="float" null="1">
				<Notes>The stdDev of multiple levels (multiple probes mapping to the same feature/gene).  Nullable if it is a single value mapping to the feature.</Notes>
			</Field>
			<Field name="numberOfMeasurements" type="int" null="1">
				<Notes>The number of measurements in comparison examples that mapped to that feature.  (helps to indicate the value of the stdDev)</Notes>
			</Field>
			<Field name="confidenceScore" type="float" null="1">
				<Notes>The confidence score for the value. The majority of the times it will be empty</Notes>
			</Field>
			<Field name="confidenceType" type="string">
				<Notes>The type of confidence score (enumerated - pValue, Zscore, null). The majority of the times it will be empty</Notes>
			</Field>
			<Field name="source-id" type="string">
				<Notes>The ID of the environment used by the data source.</Notes>
			</Field>
		</Fields>
		<Indexes>
			<Index>
				<Notes>This index allows retrieval by the source id.</Notes>
				<IndexFields>
					<IndexField name="source-id" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>	
	</Entity>
	<Entity name="Ontology" keyType="string">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" row="4" col="6" />
		</DisplayInfo>
		<Notes>-- Environmental Ontology. http://environmentontology.org/  
		-- Plant Ontology (PO Terms). http://www.plantontology.org/   
		-- Plant Environmental Ontology (EO Terms). http://www.gramene.org/plant_ontology/index.html#eo
		</Notes>
		<Fields>
			<Field name="term" type="string">
				<Notes>Ontologgy Term.</Notes>
			</Field>
			<Field name="description" type="long-string">
				<Notes>Description of the ontology</Notes>
			</Field>
			<Field name="type" type="string">
				<Notes>Type of the ontology.</Notes>
			</Field>
			<Field name="ontologySource" type="string">
				<Notes>Enumerated value (ENVO, EO, PO).</Notes>
			</Field>			
		</Fields>
		<Indexes>
			<Index>
				<IndexFields>
					<IndexField name="term" order="ascending" />
					<IndexField name="type" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>	
	</Entity>
	<Entity name="SampleAnnotation" keyType="string">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" row="2" col="6" />
		</DisplayInfo>
		<Notes>Keeps track of ontology annotation date (and person if not automated).
		</Notes>
		<Fields>
			<Field name="annotationDate" type="date">
				<Notes>date of annotation</Notes>
			</Field>
			<Field name="source-id" type="string">
				<Notes>The ID of the environment used by the data source.</Notes>
			</Field>				
		</Fields>
		<Indexes>
			<Index>
				<Notes>This index allows retrieval by the source id.</Notes>
				<IndexFields>
					<IndexField name="source-id" order="ascending" />
				</IndexFields>
			</Index>
		</Indexes>	
	</Entity>
  </Entities>
  <Relationships>
  	<Relationship name="ImplementsReaction" from="Feature" to="ReactionInstance"
                  arity="MM" converse="ImplementedBasedOn">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Implements\nReaction" />
      </DisplayInfo>
      <Notes>This relationship connects features to reaction instances
      that exist because the feature is included in a model.</Notes>
    </Relationship>
    <Relationship name="Treed" from="Source" to="Tree" arity="1M"
    			  converse="IsTreeFrom">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Treed" />
      </DisplayInfo>
      <Notes>This relationship connects a tree to the source database from
      which it was generated.</Notes>
    </Relationship>
    <Relationship name="UsesCodons" from="Genome" to="CodonUsage" arity="1M"
    			  converse="AreCodonsFor">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Uses\nCodons" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the various codon usage
      records for it.</Notes>
    </Relationship>
    <Relationship name="IsModifiedToBuildTree" from="Tree"
      to="Tree" arity="1M" converse="IsModificationOfTree">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" col="4" row="4" fixed="1"
                    caption="Is Modified\nTo Build\nTree" />
      </DisplayInfo>
      <Notes>Relates a tree to other trees built from it.</Notes>
      <Fields>
        <Field name="modification-type" type="string">
          <Notes>description of how the tree was modified (rerooted,
          annotated, etc.)</Notes>
        </Field>
        <Field name="modification-value" type="string">
          <Notes>description of any parameters used to derive the
          modification</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsModifiedToBuildAlignment" from="Alignment"
      to="Alignment" arity="1M" converse="IsModificationOfAlignment">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" col="3" row="4" fixed="1"
                    caption="Is Modified\nTo Build\nAlignment" />
      </DisplayInfo>
      <Notes>Relates an alignment to other alignments built from it.</Notes>
      <Fields>
        <Field name="modification-type" type="string">
          <Notes>description of how the alignment was modified</Notes>
        </Field>
        <Field name="modification-value" type="string">
          <Notes>description of any parameters used to derive the
          modification</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="StrainParentOf" from="Strain"
      to="Strain" arity="1M" converse="DerivedFromStrain">
      <DisplayInfo theme="tan">
        <RegionInfo name="Strain" caption="Strain\nParentOf" />
      </DisplayInfo>
      <Notes>The recursive StrainParentOf relationship organizes derived
      organisms into a tree based on parent/child relationships.</Notes>
    </Relationship>
    <Relationship name="GenomeParentOf" from="Genome"
      to="Strain" arity="1M" converse="DerivedFromGenome">
      <DisplayInfo theme="tan">
        <RegionInfo name="Strain" caption="Genome\nParentOf"/>
      </DisplayInfo>
      <Notes>The GenomeParentOf relationship specifies the direct child
      strains of a specific genome.</Notes>
    </Relationship>
    <Relationship name="HasKnockoutIn" from="Strain" to="Feature"
      arity="MM" converse="KnockedOutIn">
      <DisplayInfo theme="tan">
        <RegionInfo name="Strain" caption="Has\nKnockout\nIn"/>
      </DisplayInfo>
      <Notes>The HasKnockoutIn relationship specifies the gene knockouts in
      a particular strain.</Notes>
    </Relationship>
    <Relationship name="EvaluatedIn" from="Strain" to="ExperimentalUnit"
      arity="1M" converse="IncludesStrain">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Evaluated\nIn"/>
		<RegionInfo name="Expression_v2" caption="Includes\nStrain" row="5" col="2" />
      </DisplayInfo>
      <Notes>The EvaluatedIn relationship specifies the experimental
      units performed on a particular strain.</Notes>
    </Relationship>
    <Relationship name="HasMeasurement" from="ExperimentalUnit"
      to="Measurement" arity="1M" converse="IsMeasureOf">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Has\nMeasurement"/>
      </DisplayInfo>
      <Notes>The HasMeasurement relationship specifies a measurement(s)
      performed on a particular experimental unit.</Notes>
    </Relationship>
    <Relationship name="DescribesMeasurement" from="MeasurementDescription"
      to="Measurement" arity="1M" converse="IsDefinedBy">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Describes\nMeasurement"/>
      </DisplayInfo>
      <Notes>The DescribesMeasurement relationship specifies a description 
      for a particular measurement.</Notes>
    </Relationship>
    <Relationship name="HasExperimentalUnit" from="ExperimentMeta"
      to="ExperimentalUnit" arity="1M" converse="IsExperimentalUnitOf">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment"  caption="Has\nExperimental\nUnit"/>
		<RegionInfo name="Expression_v2" caption="Has\nExperimental\nUnit" row="4" col="1" />
      </DisplayInfo>
      <Notes>The HasExperimentalUnit relationship describes which
      ExperimentalUnits are part of a Experiment.</Notes>
    </Relationship>
    <Relationship name="PublishedExperiment" from="Publication"
      to="ExperimentMeta" arity="MM" converse="ExperimentPublishedIn">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Published\nExperiment"/>
		<RegionInfo name="Expression_v2" caption="Experiment\nPublished In" row="1" col="1" />
      </DisplayInfo>
      <Notes>The PublishedExperiment relationship describes where a
      particular experiment was published.</Notes>
    </Relationship>
    <Relationship name="IsMeasurementMethodOf" from="Protocol"
      to="Measurement" arity="1M" converse="WasMeasuredBy">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="IsMeasurement\nMethodOf"/>
      </DisplayInfo>
      <Notes>The IsMeasurementMethodOf relationship describes which protocol
      was used to take a measurement.</Notes>
    </Relationship>
    <Relationship name="PublishedProtocol" from="Publication"
      to="Protocol" arity="1M" converse="ProtocolPublishedIn">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Published\nProtocol"/>
      </DisplayInfo>
      <Notes>The ProtocolPublishedIn relationship describes where a
      particular protocol was published.</Notes>
    </Relationship>
    <Relationship name="IsContextOf" from="Environment"
      to="ExperimentalUnit" arity="1M" converse="HasEnvironment">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="IsContextOf"/>
		<RegionInfo name="Expression_v2" caption="IsContextOf" row="6" col="1" />
      </DisplayInfo>
      <Notes>The IsContextOf relationship describes the enviroment a
      subexperiment defined by an ExperimentalUnit was performed in.</Notes>
    </Relationship>
    <Relationship name="UsedIn" from="Media" to="Environment"
      arity="1M" converse="HasMedia">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="UsedIn"/>
      </DisplayInfo>
      <Notes>The UsedIn relationship defines which media is used by an
      Environment.</Notes>
    </Relationship>
    <Relationship name="PerformedExperiment" from="Person"
      to="ExperimentMeta" arity="MM" converse="PerformedBy">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Performed\nExperiment"/>
      </DisplayInfo>
      <Notes>Denotes that a Person was associated with a
      Experiment in some role.</Notes>
      <Fields>
        <Field name="role" type="string">
          <Notes>Describes the role the person played in the experiment.
          Examples are Primary Investigator, Designer, Experimentalist, etc.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="HasPresenceOf" from="Media" to="Compound"
      arity="MM" converse="IsPresentIn">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nPresent\nIn" />
        <RegionInfo name="Experiment" caption="Has\nPresence\nOf"/>
      </DisplayInfo>
      <Notes>This relationship connects a media to the compounds that
      occur in it. The intersection data describes how much of each
      compound can be found.</Notes>
      <Fields>
        <Field name="concentration" type="float">
          <Notes>concentration of the compound in the media</Notes>
        </Field>
        <Field name="units" type="string">
          <Notes>vol%, g/L, or molar (mol/L).</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IncludesAdditionalCompounds" from="Environment"
      to="Compound" arity="MM" converse="IncludedIn">
      <DisplayInfo theme="gray">
        <RegionInfo name="Experiment" caption="Includes\nAdditional\nCompounds"/>
      </DisplayInfo>
      <Notes>This relationship connects a environment to the compounds that
      occur in it. The intersection data describes how much of each
      compound can be found.</Notes>
      <Fields>
        <Field name="concentration" type="float">
          <Notes>concentration of the compound in the environment</Notes>
        </Field>
        <Field name="units" type="string">
          <Notes>vol%, g/L, or molar (mol/L).</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="SupersedesAlignment" converse="IsSupersededByAlignment"
      arity="1M" from="Alignment" to="Alignment">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" fixed="1"
          caption="Supersedes\nAlignment" row="3" col="1" />
      </DisplayInfo>
      <Notes>This relationship connects an alignment to the alignments
      it replaces.</Notes>
      <Fields>
        <Field name="successor-type" type="string">
          <Notes>Indicates whether sequences were removed or added
          to create the new alignment.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="SupersedesTree" converse="IsSupersededByTree"
      arity="1M" from="Tree" to="Tree">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" fixed="1" caption="Supersedes\nTree"
          row="3" col="5" />
      </DisplayInfo>
      <Notes>This relationship connects a tree to the trees
      it replaces.</Notes>
      <Fields>
        <Field name="successor-type" type="string">
          <Notes>Indicates whether sequences were removed or added
          to create the new tree.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IncludesAlignmentRow" converse="IsAlignmentRowIn"
      arity="1M" from="Alignment" to="AlignmentRow">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Includes\nAlignment Row" />
      </DisplayInfo>
      <Notes>This relationship connects an alignment to its component
      rows.</Notes>
    </Relationship>
    <Relationship name="DescribesAlignment" converse="HasAlignmentAttribute"
      arity="MM" from="AlignmentAttribute" to="Alignment">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Describes\nAlignment" />
      </DisplayInfo>
      <Notes>This relationship connects an alignment to its free-form
      attributes.</Notes>
      <Fields>
        <Field name="value" type="string">
          <Notes>value of this attribute</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="DescribesTree" converse="HasTreeAttribute"
      arity="MM" from="TreeAttribute" to="Tree">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Describes\nTree" />
      </DisplayInfo>
      <Notes>This relationship connects a tree to its free-form
      attributes.</Notes>
      <Fields>
        <Field name="value" type="string">
          <Notes>value of this attribute</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="DescribesTreeNode" converse="HasNodeAttribute"
      arity="MM" from="TreeNodeAttribute" to="Tree">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Describes\nTree Node"
          fixed="1" row="2" col="5" />
      </DisplayInfo>
      <Notes>This relationship connects an tree to the free-form
      attributes of its nodes.</Notes>
      <Fields>
        <Field name="value" type="string">
          <Notes>value of this attribute</Notes>
        </Field>
        <Field name="node-id" type="string">
          <Notes>ID of the node described by the attribute</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsUsedToBuildTree" converse="IsBuiltFromAlignment"
      arity="1M" to="Tree" from="Alignment">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Is Used to\nBuild Tree" />
      </DisplayInfo>
      <Notes>This relationship connects each tree to the alignment from
      which it is built. There is at most one.</Notes>
    </Relationship>
    <Relationship name="ContainsAlignedProtein" arity="MM"
      from="AlignmentRow" to="ProteinSequence" converse="IsAlignedProteinComponentOf">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Contains\nAligned\nProtein" />
      </DisplayInfo>
      <Notes>This relationship connects a protein alignment row to the
      protein sequences from which its components are formed.</Notes>
      <Fields>
        <Field name="index-in-concatenation" type="int">
          <Notes>1-based ordinal position in the alignment row of this
          protein sequence</Notes>
        </Field>
        <Field name="beg-pos-in-parent" type="int">
          <Notes>1-based position in the protein sequence of the first
          amino acid that appears in the alignment</Notes>
        </Field>
        <Field name="end-pos-in-parent" type="int">
          <Notes>1-based position in the protein sequence of the last
          amino acid that appears in the alignment</Notes>
        </Field>
        <Field name="parent-seq-len" type="int">
          <Notes>length of original sequence</Notes>
        </Field>
        <Field name="beg-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          protein sequence begins</Notes>
        </Field>
        <Field name="end-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          protein sequence ends</Notes>
        </Field>
        <Field name="kb-feature-id" type="string">
          <Notes>ID of the feature relevant to this protein, or an
          empty string if the protein is not specific to a genome</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="ContainsAlignedDNA" arity="MM"
      from="AlignmentRow" to="ContigSequence" converse="IsAlignedDNAComponentOf">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Contains\nAligned\nDNA" />
      </DisplayInfo>
      <Notes>This relationship connects a nucleotide alignment row to the
      contig sequences from which its components are formed.</Notes>
      <Fields>
        <Field name="index-in-concatenation" type="int">
          <Notes>1-based ordinal position in the alignment row of this
          nucleotide sequence</Notes>
        </Field>
        <Field name="beg-pos-in-parent" type="int">
          <Notes>1-based position in the contig sequence of the first
          nucleotide that appears in the alignment</Notes>
        </Field>
        <Field name="end-pos-in-parent" type="int">
          <Notes>1-based position in the contig sequence of the last
          nucleotide that appears in the alignment</Notes>
        </Field>
        <Field name="parent-seq-len" type="int">
          <Notes>length of original sequence</Notes>
        </Field>
        <Field name="beg-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          nucleotide sequence begins</Notes>
        </Field>
        <Field name="end-pos-aln" type="int">
          <Notes>the 1-based column index in the alignment where this
          nucleotide sequence ends</Notes>
        </Field>
        <Field name="kb-feature-id" type="string">
          <Notes>ID of the feature relevant to this sequence, or an
          empty string if the sequence is not specific to a genome</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="Aligned" from="Source" to="Alignment"
      arity="1M" converse="WasAlignedBy">
      <DisplayInfo theme="purple">
        <RegionInfo name="Alignments" caption="Aligned" />
      </DisplayInfo>
      <Notes>This relationship connects an alignment to the database
      from which it was generated.</Notes>
    </Relationship>
    <Relationship name="HasVariationIn" from="Contig"
      to="ObservationalUnit" arity="MM" converse="IsVariedIn">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Has\nVariation\nIn" />
      </DisplayInfo>
      <Notes>This relationship defines an observational unit's DNA variation
      from a contig in the reference genome.</Notes>
      <Fields>
        <Field name="position" type="int">
          <Notes>Position of this variation in the reference contig.</Notes>
        </Field>
        <Field name="len" type="int">
          <Notes>Length of the variation in the reference contig. A length
          of zero indicates an insertion.</Notes>
        </Field>
        <Field name="data" type="string">
          <Notes>Replacement DNA for the variation on the primary chromosome. An
          empty string indicates a deletion. The primary chromosome is chosen
          arbitrarily among the two chromosomes of a plant's chromosome pair
          (one coming from the mother and one from the father).</Notes>
        </Field>
        <Field name="data2" type="string">
          <Notes>Replacement DNA for the variation on the secondary chromosome.
          This will frequently be the same as the primary chromosome string.</Notes>
        </Field>
        <Field name="quality" type="float">
          <Notes>Quality score assigned to this variation.</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index allows you to look for a variation by contig
        and position.</Notes>
        <IndexFields>
          <IndexField name="position" order="ascending" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="HasTrait" from="ObservationalUnit"
      to="Trait" arity="MM" converse="Measures">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Measures" />
      </DisplayInfo>
      <Notes>This relationship contains the measurement values of a trait on a specific observational Unit</Notes>
      <Fields>
        <Field name="value" type="float">
          <Notes>value of the trait measurement</Notes>
        </Field>
        <Field name="statistic-type" type="string">
          <Notes>text description of the statistic type (e.g. mean, median)</Notes>
        </Field>
        <Field name="measure-id" type="string">
          <Notes>internal ID given to this measurement</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="Impacts" from="Trait" to="Contig"
      arity="MM" converse="IsImpactedBy">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Is\nImpacted\nBy" />
      </DisplayInfo>
      <Notes>This relationship contains the best scoring statistical correlations between measured traits and the responsible alleles.</Notes>
      <Fields>
        <Field name="source-name" type="string">
          <Notes>Name of the study which analyzed the data and determined that a variation has impact on a trait</Notes>
        </Field>
        <Field name="rank" type="int">
          <Notes>Rank of the position among all positions correlated with this trait.</Notes>
        </Field>
        <Field name="pvalue" type="float">
          <Notes>P-value of the correlation between the variation and the trait</Notes>
        </Field>
        <Field name="position" type="int">
          <Notes>Position in the reference contig where the trait
          has an impact.</Notes>
        </Field>
      </Fields>
      <ToIndex>
        <Notes>This index allows you to look for trait impact by contig ID
        and position.</Notes>
        <IndexFields>
          <IndexField name="position" order="ascending" />
        </IndexFields>
      </ToIndex>
    </Relationship>
    <Relationship name="IsAssayOf" from="Assay" to="StudyExperiment"
      arity="1M" converse="IsAssayedBy">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Is\nAssayed\nBy" />
      </DisplayInfo>
      <Notes>This relationship associates each assay with the relevant
      experiments.</Notes>
    </Relationship>
    <Relationship name="HasUnits" from="Locality" to="ObservationalUnit"
      arity="1M" converse="IsLocated">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Has Units" />
      </DisplayInfo>
      <Notes>This relationship associates observational units with the
      geographic location where the unit is planted.</Notes>
    </Relationship>
    <Relationship name="IncludesPart" from="StudyExperiment"
      to="ObservationalUnit" arity="1M" converse="IsPartOf">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Is\nPart\nOf" />
      </DisplayInfo>
      <Notes>This relationship associates observational units with the
      experiments that generated the data on them.</Notes>
    </Relationship>
    <Relationship name="IsReferencedBy" from="Genome"
      to="ObservationalUnit" arity="1M" converse="UsesReference">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Is\nReferenced\nBy" />
      </DisplayInfo>
      <Notes>This relationship associates each observational unit with the reference
      genome that it will be compared to.  All variations will be differences
      between the observational unit and the reference.</Notes>
    </Relationship>
    <Relationship name="IsRepresentedBy" from="TaxonomicGrouping"
      to="ObservationalUnit" arity="1M" converse="DefinedBy">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Defined\nBy" />
      </DisplayInfo>
      <Notes>This relationship associates observational units with a genus,
      species, strain, and/or variety that was the source material.</Notes>
    </Relationship>
    <Relationship name="IsSummarizedBy" from="Contig"
      to="AlleleFrequency" arity="1M" converse="Summarizes">
      <DisplayInfo theme="purple">
        <RegionInfo name="GenoPheno" caption="Summarizes" />
      </DisplayInfo>
      <Notes>This relationship describes the statistical frequencies of the
      most common alleles in various positions on the reference contig.</Notes>
      <Fields>
        <Field name="position" type="int">
          <Notes>Position in the reference contig where the trait
          has an impact.</Notes>
        </Field>
      </Fields>
      <ToIndex>
        <Notes>This index allows you to look for allelle frequency by contig ID
        and position.</Notes>
        <IndexFields>
          <IndexField name="position" order="ascending" />
        </IndexFields>
      </ToIndex>
    </Relationship>
    <Relationship name="Formulated" from="Source" to="CoregulatedSet"
      arity="1M" converse="WasFormulatedBy">
      <Notes>This relationship connects a coregulated set to the
      source organization that originally computed it.</Notes>
    </Relationship>
    <Relationship name="Involves" from="Reaction" to="LocalizedCompound"
      arity="MM" converse="IsInvolvedIn">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nInvolved\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects a reaction to the
      specific localized compounds that participate in it.</Notes>
      <Fields>
        <Field name="coefficient" type="float">
          <Notes>Number of molecules of the compound that participate
          in a single instance of the reaction. For example, if a
          reaction produces two water molecules, the stoichiometry of
          water for the reaction would be two. When a reaction is
          written on paper in chemical notation, the stoichiometry is
          the number next to the chemical formula of the
          compound. The value is negative for substrates and positive
          for products.</Notes>
        </Field>
        <Field name="cofactor" type="boolean">
          <Notes>TRUE if the compound is a cofactor; FALSE if it is a major
          component of the reaction.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="ParticipatesAs" from="Compound"
      to="LocalizedCompound" arity="1M" converse="IsParticipationOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nParticipation\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a generic compound to a specific compound
	  where subceullar location has been specified.</Notes>
    </Relationship>
    <Relationship name="IsParticipatingAt" from="Location"
      to="LocalizedCompound" arity="1M" converse="ParticipatesAt">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Participates\nAt" />
      </DisplayInfo>
      <Notes>This relationship connects a localized compound to the
      location in which it occurs during one or more reactions.</Notes>
    </Relationship>
    <Relationship name="ConsistsOfCompounds" from="Compound"
      to="Compound" arity="MM" converse="ComponentOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Experiment" caption="Consists Of\nCompounds"
                    row="8" col="6" fixed="1"/>
      </DisplayInfo>
      <Notes>This relationship defines the subcompounds that make up a
      compound. For example, CoCl2-6H2O is made up of 1 Co2+, 2 Cl-, and
      6 H2O.</Notes>
        <Fields>
          <Field name="molar-ratio" type="float">
          <Notes>Number of molecules of the subcompound that make up
          the compound. A -1 in this field signifies that although
          the subcompound is present in the compound, the molar
          ratio is unknown.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="Controls" from="Feature" to="CoregulatedSet"
      arity="MM" converse="IsControlledUsing">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Controls"
          fixed="1" row="3" col="3" />
      </DisplayInfo>
      <Notes>This relationship connects a coregulated set to the
      features that are used as its transcription factors.</Notes>
    </Relationship>
    <Relationship name="Provided" from="Source" to="Subsystem"
      arity="1M" converse="WasProvidedBy">
      <DisplayInfo theme="blue">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a source (core) database
      to the subsystems it submitted to the knowledge base.</Notes>
    </Relationship>
    <Relationship name="IsOwnerOf" from="Genome" to="Feature"
      arity="1M" converse="IsOwnedBy">
      <DisplayInfo theme="green">
        <RegionInfo name="" caption="Is\nOwned\nBy" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the features it
      contains. Though technically redundant (the information is
      available from the feature's contigs), it simplifies the
      extremely common process of finding all features for a
      genome.</Notes>
    </Relationship>
    <Relationship name="HasStep" from="Complex" to="Reaction"
      arity="MM" converse="IsStepOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nStep\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a complex to the reactions it
      catalyzes.</Notes>
    </Relationship>
    <Relationship name="Manages" from="Model" to="Biomass"
      arity="1M" converse="IsManagedBy">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Manages" />
      </DisplayInfo>
      <Notes>This relationship connects a model to its associated biomass
      composition reactions.</Notes>
    </Relationship>
    <Relationship name="IsComprisedOf" from="Biomass"
      to="CompoundInstance" arity="MM" converse="Comprises">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nComprised\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a biomass composition reaction to the
      compounds specified as contained in the biomass.</Notes>
      <Fields>
        <Field name="coefficient" type="float">
          <Notes>number of millimoles of the compound instance that exists in one
          gram cell dry weight of biomass</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="HasUsage" from="LocalizedCompound"
      to="CompoundInstance" arity="1M" converse="IsUsageOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Has\nUsage" />
      </DisplayInfo>
      <Notes>This relationship connects a specific compound in a model to the localized
      compound to which it corresponds.</Notes>
    </Relationship>
    <Relationship name="IsDividedInto" from="Model"
      to="LocationInstance" arity="1M" converse="IsDivisionOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nDivision\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a model to its instances of
      subcellular locations that participate in the model.</Notes>
    </Relationship>
    <Relationship name="IsInstantiatedBy" from="Location"
      to="LocationInstance" arity="1M" converse="IsInstanceOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nInstance\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a subcellular location to the instances
      of that location that occur in models.</Notes>
    </Relationship>
    <Relationship name="IsRealLocationOf" from="LocationInstance"
      to="CompoundInstance" arity="1M" converse="HasRealLocationIn">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is Real\nLocation\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a specific instance of a compound in a model
      to the specific instance of the model subcellular location where the compound exists.</Notes>
    </Relationship>
    <Relationship name="IsReagentIn" from="CompoundInstance"
      to="ReactionInstance" arity="MM" converse="Targets">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nReagent\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects a compound instance to the reaction instance
      in which it is transformed.</Notes>
      <Fields>
        <Field name="coefficient" type="float">
          <Notes>Number of molecules of the compound that participate
          in a single instance of the reaction. For example, if a
          reaction produces two water molecules, the stoichiometry of
          water for the reaction would be two. When a reaction is
          written on paper in chemical notation, the stoichiometry is
          the number next to the chemical formula of the
          compound. The value is negative for substrates and positive
          for products.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="Submitted" from="Source" to="Genome"
      arity="1M" converse="WasSubmittedBy">
      <DisplayInfo theme="red">
        <RegionInfo name="" caption="Was\nSubmitted\nBy" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the
      core database from which it was loaded.</Notes>
    </Relationship>
    <Relationship name="IsComposedOf" from="Genome" to="Contig"
      arity="1M" converse="IsComponentOf">
      <DisplayInfo theme="red">
        <RegionInfo name="" caption="Is\nComposed\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to its
      constituent contigs. Unlike contig sequences, a
      contig belongs to only one genome.</Notes>
    </Relationship>
    <Relationship name="Encompasses" from="Feature" to="Feature"
      arity="MM" converse="IsEncompassedIn">
      <DisplayInfo theme="green">
        <RegionInfo name="" row="3" col="4" fixed="1"
          caption="Encompasses" />
      </DisplayInfo>
      <Notes>This relationship connects a feature to a related
      feature; for example, it would connect a gene to its
      constituent splice variants, and the splice variants to their
      exons.</Notes>
    </Relationship>
    <Relationship name="IsSequenceOf" from="ContigSequence"
      to="Contig" converse="HasAsSequence" arity="1M">
      <DisplayInfo theme="red">
        <RegionInfo name="" caption="Has as\nSequence" />
      </DisplayInfo>
      <Notes>This relationship connects a Contig as it occurs in a
      genome to the Contig Sequence that represents the physical
      DNA base pairs. A contig sequence may represent many contigs,
      but each contig has only one sequence.</Notes>
    </Relationship>
    <Relationship name="HasRequirementOf" from="Model"
      to="ReactionInstance" arity="1M" converse="IsARequirementOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Has\nRequirement\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a model to the instances of
      reactions that represent how the reactions occur in the model.</Notes>
    </Relationship>
    <Relationship name="HasCompoundAliasFrom" from="Source"
      to="Compound" arity="MM" converse="UsesAliasForCompound">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Has Compound\nAlias From" />
      </DisplayInfo>
      <Notes>This relationship connects a source (database or organization)
      with the compounds for which it has assigned names (aliases).
      The alias itself is stored as intersection data.</Notes>
      <Fields>
        <Field name="alias" type="string">
          <Notes>alias for the compound assigned by the source</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index can be used to look up a compound alias
        using the alias itself and the source.</Notes>
        <IndexFields>
          <IndexField name="alias" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="HasReactionAliasFrom" from="Source"
      to="Reaction" arity="MM" converse="UsesAliasForReaction">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Has Reaction\nAlias From" />
      </DisplayInfo>
      <Notes>This relationship connects a source (database or organization)
      with the reactions for which it has assigned names (aliases).
      The alias itself is stored as intersection data.</Notes>
      <Fields>
        <Field name="alias" type="string">
          <Notes>alias for the reaction assigned by the source</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index can be used to look up a reaction alias
        using the alias itself and the source.</Notes>
        <IndexFields>
          <IndexField name="alias" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="IsTriggeredBy" from="Complex" to="Role"
      arity="MM" converse="Triggers">
      <DisplayInfo theme="navy" caption="Triggers">
        <RegionInfo name="Chemistry" />
        <RegionInfo name="Models" />
      </DisplayInfo>
      <Notes>This connects a complex to the roles that work together to form the complex.</Notes>
      <Fields>
        <Field name="optional" type="boolean">
          <Notes>TRUE if the role is not necessarily required to trigger the
          complex, else FALSE</Notes>
        </Field>
        <Field name="type" type="string">
          <Notes>a string code that is used to determine whether a complex
          should be added to a model</Notes>
        </Field>
        <Field name="triggering" type="boolean">
          <Notes>TRUE if the presence of the role requires including the
          complex in the model, else FALSE</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsExemplarOf" from="Feature" to="Role"
      arity="MM" converse="HasAsExemplar">
      <DisplayInfo theme="navy" caption="Has As\nExemplar">
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>This relationship links a role to a feature that provides a typical
      example of how the role is implemented.</Notes>
    </Relationship>
    <Relationship name="IsCoupledTo" arity="MM" from="Family"
      to="Family" converse="IsCoupledWith">
      <DisplayInfo theme="brown">
        <RegionInfo name="Annotations" caption="Is\nCoupled\nTo"
          row="5" col="6" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship connects two FIGfams that we believe to be related
      either because their members occur in proximity on chromosomes or because
      the members are expressed together. Such a relationship is evidence the
      functions of the FIGfams are themselves related. This relationship is
      commutative; only the instance in which the first FIGfam has a lower ID
      than the second is stored.</Notes>
      <Fields>
        <Field name="co-occurrence-evidence" type="counter">
          <Notes>number of times members of the two FIGfams occur close to each
          other on chromosomes</Notes>
        </Field>
        <Field name="co-expression-evidence" type="counter">
          <Notes>number of times members of the two FIGfams are co-expressed in
          expression data experiments</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="HasRepresentativeOf" arity="MM"
      from="Genome" to="Family" converse="IsRepresentedIn">
      <DisplayInfo theme="brown">
        <RegionInfo name="Annotations" caption="Has\nRepresentative\nOf" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the FIGfam protein families
      for which it has representative proteins. This information can be computed
      from other relationships, but it is provided explicitly to allow fast access
      to a genome's FIGfam profile.</Notes>
    </Relationship>
    <Relationship name="IndicatedLevelsFor" arity="MM"
      from="ProbeSet" to="Feature" converse="HasLevelsFrom">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Has\nLevels\nFrom" />
      </DisplayInfo>
      <Notes>This relationship connects a feature to a probe set from which experimental
      data was produced for the feature. It contains a vector of the expression levels.</Notes>
      <Fields>
        <Field name="level-vector" type="countVector">
          <Notes>Vector of expression levels (-1, 0, 1) for the experiments, in
          sequence order.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="GeneratedLevelsFor" arity="MM"
      from="ProbeSet" to="AtomicRegulon" converse="WasGeneratedFrom">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Generated\nLevels For"
          col="3" row="7" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship connects an atomic regulon to a probe set from which experimental
      data was produced for its features. It contains a vector of the expression levels.</Notes>
      <Fields>
        <Field name="level-vector" type="countVector">
          <Notes>Vector of expression levels (-1, 0, 1) for the experiments, in
          sequence order.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="ProducedResultsFor" arity="MM"
      from="ProbeSet" to="Genome" converse="HadResultsProducedBy">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Produced\nResults For" />
      </DisplayInfo>
      <Notes>This relationship connects a probe set to a genome for which it was
      used to produce experimental results. In general, a probe set is used for
      only one genome and vice versa, but this is not a requirement.</Notes>
    </Relationship>
    <Relationship name="HasResultsIn" arity="1M" from="ProbeSet"
      to="Experiment" converse="HasResultsFor">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Has\nResults\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects a probe set to the experiments that were
      applied to it.</Notes>
      <Fields>
        <Field name="sequence" type="int">
          <Notes>Sequence number of this experiment in the various result vectors.</Notes>
        </Field>
      </Fields>
      <ToIndex>
        <Notes>This index allows you to access the experiments for a probe set in sequence
        order.</Notes>
        <IndexFields>
          <IndexField name="sequence" order="ascending" />
        </IndexFields>
      </ToIndex>
    </Relationship>
    <Relationship name="AffectsLevelOf" arity="MM" from="Experiment"
      to="AtomicRegulon" converse="IsAffectedIn">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Affects\nLevel Of"
          col="4" row="9" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship indicates the expression level of an atomic regulon
      for a given experiment.</Notes>
      <Fields>
        <Field name="level" type="int">
          <Notes>Indication of whether the feature is expressed (1), not expressed (-1),
          or unknown (0).</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsCoregulatedWith" arity="MM" from="Feature"
      to="Feature" converse="HasCoregulationWith">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Is\nCoregulated\nWith"
          col="1" row="2" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship connects a feature with another feature in the
      same genome with which it appears to be coregulated as a result of
      expression data analysis.</Notes>
      <Fields>
        <Field name="coefficient" type="float">
          <Notes>Pearson correlation coefficient for this coregulation.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsFormedOf" arity="1M" from="AtomicRegulon"
      to="Feature" converse="IsFormedInto">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Is Formed\nInto"
          col="1" row="6" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship connects each feature to the atomic regulon to
      which it belongs.</Notes>
    </Relationship>
    <Relationship name="IsConfiguredBy" arity="1M" from="Genome"
      to="AtomicRegulon" converse="ReflectsStateOf">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Is\nConfigured\nBy" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the atomic regulons that
      describe its state.</Notes>
    </Relationship>
    <Relationship name="HasIndicatedSignalFrom" arity="MM"
      from="Feature" to="Experiment" converse="IndicatesSignalFor">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Indicates\nSignal For" />
      </DisplayInfo>
      <Notes>This relationship connects an experiment to a feature. The feature
      expression levels inferred from the experimental results are stored here.</Notes>
      <Fields>
        <Field name="rma-value" type="float">
          <Notes>Normalized expression value for this feature under the experiment's
          conditions.</Notes>
        </Field>
        <Field name="level" type="int">
          <Notes>Indication of whether the feature is expressed (1), not expressed (-1),
          or unknown (0).</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="HasValueFor" arity="MM" from="Experiment"
      to="Attribute" converse="HasValueIn">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Has\nValue\nFor" />
      </DisplayInfo>
      <Notes>This relationship connects an experiment to its attributes. The attribute
      values are stored here.</Notes>
      <Fields>
        <Field name="value" type="string">
          <Notes>Value of this attribute in the given experiment. This is always encoded
          as a string, but may in fact be a number.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="OperatesIn" arity="MM" from="Experiment"
      to="Media" converse="IsUtilizedIn">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Operates\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects an experiment to the media in which the
      experiment took place.</Notes>
    </Relationship>
    <Relationship name="IsRegulatedIn" arity="MM" from="Feature"
      to="CoregulatedSet" converse="IsRegulatedSetOf">
      <DisplayInfo theme="cyan">
        <RegionInfo name="Expression" caption="Is\nRegulated\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects a feature to the set of coregulated features.</Notes>
    </Relationship>
    <Relationship name="IsFamilyFor" arity="MM" from="Family"
      to="Role" converse="DeterminesFunctionOf">
      <DisplayInfo theme="brown">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>This relationship connects an isofunctional family to the roles that
      make up its assigned function.</Notes>
    </Relationship>
    <Relationship name="IsConsistentWith" arity="MM" from="EcNumber"
      to="Role" converse="IsConsistentTo">
      <DisplayInfo theme="navy" caption="Is\nConsistent\nWith">
        <RegionInfo name="Chemistry" row="6" col="3" fixed="1" />
      </DisplayInfo>
      <Notes>This relationship connects a functional role to the EC numbers consistent
      with the chemistry described in the role.</Notes>
    </Relationship>
    <Relationship name="IsModeledBy" arity="1M" from="Genome"
      to="Model" converse="Models">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Models" />
      </DisplayInfo>
      <Notes>A genome can be modeled by many different models, but a model belongs
      to only one genome.</Notes>
    </Relationship>
    <Relationship name="IsExecutedAs" arity="1M" from="Reaction"
      to="ReactionInstance" converse="IsExecutionOf">
      <DisplayInfo theme="navy">
        <RegionInfo name="Models" caption="Is\nExecution\nOf" />
      </DisplayInfo>
      <Notes>This relationship links a reaction to the way it is used in a model.</Notes>
    </Relationship>
    <Relationship name="IsTerminusFor" from="Compound" to="Scenario"
      arity="MM" converse="HasAsTerminus">
      <DisplayInfo caption="Has As\nTerminus" theme="ivory">
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>A terminus for a scenario is a compound that acts as its
      input or output. A compound can be the terminus for many scenarios,
      and a scenario will have many termini. The relationship attributes
      indicate whether the compound is an input to the scenario or an
      output. In some cases, there may be multiple alternative output
      groups. This is also indicated by the attributes.</Notes>
      <Fields>
        <Field name="group-number" type="int">
          <Notes>If zero, then the compound is an input. If one, the compound is
          an output. If two, the compound is an auxiliary output.</Notes>
        </Field>
      </Fields>
      <ToIndex>
        <Notes>This index allows the application to view a scenario's
        compounds by group.</Notes>
        <IndexFields>
          <IndexField name="group-number" order="ascending" />
        </IndexFields>
      </ToIndex>
    </Relationship>
    <Relationship name="IsSuperclassOf" arity="1M"
      from="SubsystemClass" to="SubsystemClass" converse="IsSubclassOf">
      <DisplayInfo caption="Is\nSuperclass\nOf" theme="blue"
        col="7" row="1" fixed="1">
        <RegionInfo name="Subsystem" row="1" col="6" />
        <RegionInfo name="Chemistry" row="6" col="6"
          caption="Is\nSubclass\nOf" />
      </DisplayInfo>
      <Notes>This is a recursive relationship that imposes a hierarchy on
      the subsystem classes.</Notes>
    </Relationship>
    <Relationship name="Describes" from="Subsystem" to="Variant"
      arity="1M" converse="IsDescribedBy">
      <DisplayInfo theme="blue">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a subsystem to the individual
      variants used to implement it. Each variant contains a slightly
      different subset of the roles in the parent subsystem.</Notes>
    </Relationship>
    <Relationship name="Displays" from="Diagram" to="Reaction"
      arity="MM" converse="IsDisplayedOn">
      <DisplayInfo theme="ivory" caption="Is\nDisplayed\nOn">
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>This relationship connects a diagram to its reactions. A
      diagram shows multiple reactions, and a reaction can be on many
      diagrams.</Notes>
      <Fields>
        <Field name="location" type="rectangle">
          <Notes>Location of the reaction's node on the diagram.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsRelevantFor" from="Diagram" to="Subsystem"
      arity="MM" converse="IsRelevantTo">
      <DisplayInfo theme="ivory" caption="Is\nRelevant\nFor">
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>This relationship connects a diagram to the subsystems that are depicted on
      it. Only diagrams which are useful in curating or annotation the subsystem are
      specified in this relationship.</Notes>
    </Relationship>
    <Relationship name="IsImplementedBy" from="Variant" to="SSRow"
      arity="1M" converse="Implements">
      <DisplayInfo theme="blue" caption="Is\nImplemented\nBy"
        row="6" col="7">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a variant to the physical machines
      that implement it in the genomes. A variant is implemented by many
      machines, but a machine belongs to only one variant.</Notes>
    </Relationship>
    <Relationship name="Uses" from="Genome" to="SSRow"
      arity="1M" converse="IsUsedBy">
      <DisplayInfo theme="blue" caption="Is\nUsed\nBy">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a genome to the machines that form
      its metabolic pathways. A genome can use many machines, but a
      machine is used by exactly one genome.</Notes>
    </Relationship>
    <Relationship name="Includes" from="Subsystem" to="Role"
      arity="MM" converse="IsIncludedIn">
      <DisplayInfo theme="blue" caption="Includes">
        <RegionInfo name="Subsystem" />
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>A subsystem is defined by its roles. The subsystem's variants
      contain slightly different sets of roles, but all of the roles in a
      variant must be connected to the parent subsystem by this
      relationship. A subsystem always has at least one role, and a role
      always belongs to at least one subsystem.</Notes>
      <Fields>
        <Field name="sequence" type="counter">
          <Notes>Sequence number of the role within the subsystem.
          When the roles are formed into a variant, they will
          generally appear in sequence order.</Notes>
        </Field>
        <Field name="abbreviation" type="string">
          <Notes>Abbreviation for this role in this subsystem. The
          abbreviations are used in columnar displays, and they also
          appear on diagrams.</Notes>
        </Field>
        <Field name="auxiliary" type="boolean">
          <Notes>TRUE if this is an auxiliary role, or FALSE if this role
          is a functioning part of the subsystem.</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index insures that the roles of the subsystem are
        presented in sequence order.</Notes>
        <IndexFields>
          <IndexField name="sequence" order="ascending" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="IsFunctionalIn" from="Role" to="Feature"
      arity="MM" converse="HasFunctional">
      <DisplayInfo theme="green">
        <RegionInfo name="" caption="Is\nFunctional\nIn" />
      </DisplayInfo>
      <Notes>This relationship connects a role with the features in which
      it plays a functional part.</Notes>
      <Asides>In most cases, the functional assignment of a feature is also its
      role; however, some features implement multiple roles, and each individual
      role is connected by a separate instance
      of this relationship.</Asides>
    </Relationship>
    <Relationship name="Shows" from="Diagram" to="Compound"
      arity="MM" converse="IsShownOn">
      <DisplayInfo theme="ivory" fixed="1" caption="Is\nShown\nOn"
        row="2" col="3.5">
        <RegionInfo name="Chemistry" row="2" col="2.5" />
      </DisplayInfo>
      <Notes>This relationship indicates that a compound appears on a
      particular diagram. The same compound can appear on many diagrams,
      and a diagram always contains many compounds.</Notes>
      <Fields>
        <Field name="location" type="rectangle">
          <Notes>Location of the compound's node on the diagram.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="IsRoleOf" from="Role" to="SSCell"
      arity="1M" converse="HasRole">
      <DisplayInfo caption="Is\nRole\nOf" theme="blue">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a role to the machine roles that
      represent its appearance in a molecular machine. A machine role has
      exactly one associated role, but a role may be represented by many
      machine roles.</Notes>
    </Relationship>
    <Relationship name="IsSubInstanceOf" from="Subsystem"
      to="Scenario" arity="1M" converse="Validates">
      <DisplayInfo theme="ivory" caption="Is Sub-\nInstance\nOf"
        fixed="1" row="1" col="7">
        <RegionInfo name="Chemistry" row="1" col="6" />
      </DisplayInfo>
      <Notes>This relationship connects a scenario to its subsystem it
      validates. A scenario belongs to exactly one subsystem, but a
      subsystem may have multiple scenarios.</Notes>
    </Relationship>
    <Relationship name="Overlaps" from="Scenario" to="Diagram"
      arity="MM" converse="IncludesPartOf">
      <DisplayInfo theme="ivory" fixed="1" row="2" col="5.5">
        <RegionInfo name="Chemistry" row="2" col="4.5" />
      </DisplayInfo>
      <Notes>A Scenario overlaps a diagram when the diagram displays a
      portion of the reactions that make up the scenario. A scenario may
      overlap many diagrams, and a diagram may be include portions of many
      scenarios.</Notes>
    </Relationship>
    <Relationship name="HasParticipant" from="Scenario" to="Reaction"
      arity="MM" converse="ParticipatesIn">
      <DisplayInfo theme="ivory" caption="Has\nParticipant"
        row="2" col="4.5" fixed="1">
        <RegionInfo name="Chemistry" row="2" col="3.5" />
      </DisplayInfo>
      <Notes>A scenario consists of many participant reactions that
      convert the input compounds to output compounds. A single reaction
      may participate in many scenarios.</Notes>
      <Fields>
        <Field name="type" type="int">
          <Notes>Indicates the type of participaton. If 0, the
          reaction is in the main pathway of the scenario. If 1, the
          reaction is necessary to make the model work but is not in
          the subsystem. If 2, the reaction is part of the subsystem
          but should not be included in the modelling process.</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index presents the reactions in the scenario in
        order from most important to least important.</Notes>
        <IndexFields>
          <IndexField name="type" order="ascending" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="IsInPair" from="Feature" to="Pairing"
      arity="MM" converse="IsPairOf">
      <DisplayInfo theme="brown" caption="Is In\nPair">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>A pairing contains exactly two protein sequences. A protein
      sequence can belong to multiple pairings. When going from a protein
      sequence to its pairings, they are presented in alphabetical order
      by sequence key.</Notes>
    </Relationship>
    <Relationship name="IsTaxonomyOf" from="TaxonomicGrouping"
      to="Genome" arity="1M" converse="IsInTaxa">
      <DisplayInfo theme="red">
        <RegionInfo name="" caption="Is In\nTaxa" />
      </DisplayInfo>
      <Notes>A genome is assigned to a particular point in the taxonomy tree, but not
      necessarily to a leaf node. In some cases, the exact species and strain is
      not available when inserting the genome, so it is placed at the lowest node
      that probably contains the actual genome.</Notes>
    </Relationship>
    <Relationship name="IsRowOf" from="SSRow" to="SSCell"
      arity="1M" converse="IsRoleFor">
      <DisplayInfo theme="blue">
        <RegionInfo name="Subsystem" caption="Is\nRole\nFor" />
      </DisplayInfo>
      <Notes>This relationship connects a subsystem spreadsheet row to its
      constituent spreadsheet cells.</Notes>
    </Relationship>
    <Relationship name="IsClassFor" arity="1M" from="SubsystemClass"
      to="Subsystem" converse="IsInClass">
      <DisplayInfo caption="Is In\nClass" theme="blue">
        <RegionInfo name="Subsystem" />
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>This relationship connects each subsystem class with the
      subsystems that belong to it. A class can contain many subsystems,
      but a subsystem is only in one class. Some subsystems are not in any
      class, but this is usually a temporary condition.</Notes>
    </Relationship>
    <Relationship name="IsAnnotatedBy" from="Feature" to="Annotation"
      arity="1M" converse="Annotates">
      <DisplayInfo theme="black" caption="Annotates">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>This relationship connects a feature to its annotations. A
      feature may have multiple annotations, but an annotation belongs to
      only one feature.</Notes>
    </Relationship>
    <Relationship name="HasMember" from="Family" to="Feature"
      arity="MM" converse="IsMemberOf">
      <DisplayInfo theme="brown" caption="Is\nMember\nOf">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>This relationship connects each feature family to its
      constituent features. A family always has many features, and a
      single feature can be found in many families.</Notes>
    </Relationship>
    <Relationship name="HasProteinMember" from="Family"
      to="ProteinSequence" arity="MM" converse="IsProteinMemberOf">
      <DisplayInfo theme="brown" caption="Is\nProtein Member\nOf">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>This relationship connects each feature family to its
      constituent protein sequences. A family always has many protein sequences,
      and a single sequence can be found in many families.</Notes>
      <Fields>
        <Field name="source-id" type="string">
          <Notes>Native identifier used for the protein in the definition
          of the family. This will be its ID in the alignment, if one
          exists.</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index orders the proteins in a family by their
        source ID.</Notes>
        <IndexFields>
          <IndexField name="source-id" order="ascending" />
        </IndexFields>
      </FromIndex>
    </Relationship>
    <Relationship name="Concerns" from="Publication" to="ProteinSequence"
      arity="MM" converse="IsATopicOf">
      <DisplayInfo theme="green">
        <RegionInfo name="" />
      </DisplayInfo>
      <Notes>This relationship connects a publication to the protein
      sequences it describes.</Notes>
    </Relationship>
    <Relationship name="IsCollectionOf" from="OTU" to="Genome"
      arity="1M" converse="IsCollectedInto">
      <DisplayInfo theme="red" caption="Is\nCollection\nOf">
        <RegionInfo name="" row="4" col="6" fixed="1" />
      </DisplayInfo>
      <Notes>A genome belongs to only one genome set. For each set, this relationship marks the genome to be used as its representative.</Notes>
      <Fields>
        <Field name="representative" type="boolean">
          <Notes>TRUE for the representative genome of the set, else FALSE.</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="AssertsFunctionFor" from="Source"
      to="ProteinSequence" converse="HasAssertedFunctionFrom" arity="MM">
      <DisplayInfo theme="black" caption="Has Asserted\nFunction From">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>Sources (users) can make assertions about protein sequence function.
      The assertion is associated with an external identifier.</Notes>
      <Fields>
        <Field name="function" type="text">
          <Notes>text of the assertion made about the identifier.
          It may be an empty string, indicating the function is unknown.</Notes>
        </Field>
        <Field name="external-id" type="string">
          <Notes>external identifier used in making the assertion</Notes>
        </Field>
        <Field name="organism" type="string">
          <Notes>organism name associated with this assertion. If the
          assertion is not associated with a specific organism, this
          will be an empty string.</Notes>
        </Field>
        <Field name="gi-number" type="counter">
          <Notes>NCBI GI number associated with the asserted identifier</Notes>
        </Field>
        <Field name="release-date" type="date">
          <Notes>date and time the assertion was downloaded</Notes>
        </Field>
      </Fields>
      <Indexes>
        <Index>
          <Notes>This index supports finding proteins by GI number.</Notes>
          <IndexFields>
            <IndexField name="gi-number" order="ascending" />
          </IndexFields>
        </Index>
        <Index>
          <Notes>This index supports finding proteins by external identifier.</Notes>
          <IndexFields>
            <IndexField name="external-id" order="ascending" />
          </IndexFields>
        </Index>
      </Indexes>
    </Relationship>
    <Relationship name="IsDeterminedBy" from="PairSet" to="Pairing"
      arity="1M" converse="Determines">
      <DisplayInfo theme="brown" caption="Determines">
        <RegionInfo name="Annotations" />
      </DisplayInfo>
      <Notes>A functional coupling evidence set exists because it has
      pairings in it, and this relationship connects the evidence set to
      its constituent pairings. A pairing cam belong to multiple evidence
      sets.</Notes>
      <Fields>
        <Field name="inverted" type="boolean">
          <Notes>A pairing is an unordered pair of protein sequences,
          but its similarity to other pairings in a pair set is
          ordered. Let (A,B) be a pairing and (X,Y) be another pairing
          in the same set. If this flag is FALSE, then (A =~ X) and (B
          =~ Y). If this flag is TRUE, then (A =~ Y) and (B =~
          X).</Notes>
        </Field>
      </Fields>
    </Relationship>
    <Relationship name="Contains" from="SSCell" to="Feature"
      arity="MM" converse="IsContainedIn">
      <DisplayInfo theme="blue" caption="Contains" row="8"
        col="5">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship connects a subsystem spreadsheet cell to the features
      that occur in it. A feature may occur in many machine roles and a
      machine role may contain many features. The subsystem annotation
      process is essentially the maintenance of this relationship.</Notes>
    </Relationship>
    <Relationship name="IsProteinFor" from="ProteinSequence"
      to="Feature" arity="1M" converse="Produces">
      <DisplayInfo caption="Is\nProtein\nFor" theme="green">
        <RegionInfo name="" />
        <RegionInfo name="Annotations" />
        <RegionInfo name="Chemistry" />
      </DisplayInfo>
      <Notes>This relationship connects a peg feature to the protein
      sequence it produces (if any). Only peg features participate in this
      relationship. A single protein sequence will frequently be produced
      by many features.</Notes>
    </Relationship>
    <Relationship name="IsLocatedIn" from="Feature" to="Contig"
      arity="MM" converse="IsLocusFor">
      <DisplayInfo theme="green">
        <RegionInfo name="" caption="Is\nLocated\nIn" />
      </DisplayInfo>
      <Notes>A feature is a set of DNA sequence fragments, the location of
	  which are specified by the fields of this relationship. Most features
      are a single contiguous fragment, so they are located in only one
      DNA sequence; however, for search optimization reasons, fragments 
	  have a maximum length, so even a single contiguous feature may 
	  participate in this relationship multiple times. Thus, it is better 
	  to use the CDMI API methods to get feature positions and sequences 
	  as those methods rejoin the fragements for contiguous features. A few 
	  features belong to multiple DNA sequences. In that case, however, all 
	  the DNA sequences belong to the same genome. A DNA sequence itself 
	  will frequently have thousands of features connected to it.</Notes>
      <Fields>
        <Field name="ordinal" type="int">
          <Notes>Sequence number of this segment, starting from 1
          and proceeding sequentially forward from there.</Notes>
        </Field>
        <Field name="begin" type="int">
          <Notes>Index (1-based) of the first residue in the contig
          that belongs to the segment.</Notes>
          <Asides>The begin value is not the start residue, it is the
          leftmost residue. If the direction is backward, it will
          actually be the end residue.</Asides>
        </Field>
        <Field name="len" type="int">
          <Notes>Length of this segment.</Notes>
        </Field>
        <Field name="dir" type="char">
          <Notes>Direction (strand) of the segment: "+" if it is
          forward and "-" if it is backward.</Notes>
        </Field>
      </Fields>
      <FromIndex>
        <Notes>This index allows the application to find all the
        segments of a feature in the proper order.</Notes>
        <IndexFields>
          <IndexField name="ordinal" order="ascending" />
        </IndexFields>
      </FromIndex>
      <ToIndex>
        <Notes>This index is the one used by applications to find all
        the feature segments that contain a specific residue.</Notes>
        <IndexFields>
          <IndexField name="begin" order="ascending" />
        </IndexFields>
      </ToIndex>
    </Relationship>
    <Relationship name="HasSection" from="ContigSequence"
      to="ContigChunk" arity="1M" converse="IsSectionOf">
      <DisplayInfo caption="Has Section" theme="red">
        <RegionInfo name="" />
      </DisplayInfo>
      <Notes>This relationship connects a contig's sequence to its DNA
      sequences.</Notes>
    </Relationship>
    <Relationship name="IsGroupFor" from="TaxonomicGrouping"
      to="TaxonomicGrouping" arity="1M" converse="IsInGroup">
      <DisplayInfo theme="red" caption="Is\nGroup\nFor">
        <RegionInfo name="" row="7" col="6" fixed="1" />
      </DisplayInfo>
      <Notes>The recursive IsGroupFor relationship organizes
      taxonomic groupings into a hierarchy based on the standard organism
      taxonomy.</Notes>
    </Relationship>
    <Relationship name="ContainsExperimentalUnit" from="ExperimentalUnitGroup" 
      to="ExperimentalUnit" arity="1M" converse="GroupedBy">
      <DisplayInfo theme="gray" caption="Contains\nExperimentalUnit">
        <RegionInfo name="Experiment" />
      </DisplayInfo>
      <Notes>Experimental units may be collected into groups, such as assay 
      plates. This relationship describes which experimenal units belong to
      which groups.</Notes>
      <Fields>
        <Field name="location" type="string">
          <Notes>The location, if any, of the experimental unit in the group.
          Often a plate locator, e.g. 'G11' for 96 well plates.</Notes>
        </Field>
        <Field name="groupMeta" type="semi-boolean">
          <Notes>Denotes that the associated ExperimentalUnit's data measures
          the group as a whole - for example, summary statistics.</Notes>
        </Field>
      </Fields>  
    </Relationship>
    <Relationship name="OrdersExperimentalUnit" from="TimeSeries" 
      to="ExperimentalUnit" arity="1M" converse="IsTimepointOf">
      <DisplayInfo theme="gray" caption="Orders\nExperimentalUnit">
        <RegionInfo name="Experiment" />
      </DisplayInfo>
      <Notes>Experimental units may be ordered into time series. This 
      relationship describes which experimenal units belong to
      which time series.</Notes>
      <Fields>
        <Field name="time" type="float">
          <Notes>The time at which the associated ExperimentUnit's data
          was taken.</Notes>
        </Field>
        <Field name="timeMeta" type="semi-boolean">
          <Notes>Denotes that the associated ExperimentalUnit's data measures
          the time series as a whole - for example, lag and doubling times
          for bacterial growth curves.</Notes>
        </Field>
      </Fields>  
    </Relationship>
    <Relationship name="CompoundMeasuredBy" from="Compound"
      to="Measurement" arity="1M" converse="MeasuresCompound">
      <DisplayInfo theme="gray" caption="Compound\nMeasuredBy">
        <RegionInfo name="Experiment" row="5" col="6" fixed="1"/>
      </DisplayInfo>
      <Notes>Denotes the compound that a measurement quantifies.</Notes>
    </Relationship>
    <Relationship name="FeatureMeasuredBy" from="Feature"
      to="Measurement" arity="1M" converse="MeasuresFeature">
      <DisplayInfo theme="gray" caption="Feature\nMeasuredBy">
        <RegionInfo name="Experiment" />
      </DisplayInfo> 
      <Notes>Denotes the feature that a measurement quantifies.</Notes> 
    </Relationship>
    <Relationship name="HasParameter" from="Environment" 
      to="Parameter" arity="MM" converse="OfEnvironment">
      <DisplayInfo theme="gray" caption="HasParameter">
        <RegionInfo name="Experiment" />
      </DisplayInfo>
      <Notes>This relationship denotes which parameters each environment has,
      as well as the value of the parameter.</Notes>
      <Fields>
        <Field name="value" type="string">
          <Notes>The value of the parameter.</Notes>
        </Field>
      </Fields>  
    </Relationship>
	<Relationship name="SeriesPublishedIn" from="Series" to="Publication" arity="MM" converse="PublicationsForSeries">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="3" row="1" fixed="1"
						caption="Series\nPublished In" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="SampleContactPerson" from="Sample" to="Person" arity="MM" converse="PersonPerformedSample">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="5" row="2" fixed="1"
						caption="Sample\nContact\nPerson" />
		</DisplayInfo>
	</Relationship>  
	<Relationship name="StrainWithSample" from="Strain" to="Sample" arity="1M" converse="SampleForStrain">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="3" row="4" fixed="1"
						caption="Strain with\nSample" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="SampleInSeries" from="Sample" to="Series" arity="MM" converse="SeriesWithSamples">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="4" row="3" fixed="1"
						caption="Sample In\nSeries" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="StrainWithPlatforms" from="Strain" to="Platform" arity="1M" converse="PlatformForStrain">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="2" row="3" fixed="1"
					caption="Strain with\nPlatforms" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="FeatureWithLevels" from="Feature" to="Log2Level" arity="1M" converse="LevelForFeature">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="5" row="6" fixed="1"
					caption="Feature\nwith\nLevels" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="PlatformWithSamples" from="Platform" to="Sample" arity="1M" converse="SampleRunOnPlatform">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="3" row="3" fixed="1"
					caption="Platform\nWith\nSamples" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="SampleLevels" from="Sample" to="Log2Level" arity="1M" converse="LevelInSample">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="4" row="5" fixed="1"
					caption="Level in\nSample" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="PersonAnnotatedSample" from="Person" to="SampleAnnotation" arity="1M" converse="SampleAnnotatedBy">
	  <DisplayInfo theme="cyan">
		<RegionInfo name="Expression_v2" col="6" row="1" fixed="1"
					caption="Person\nAnnotated\nSample" />
	  </DisplayInfo>
	  <Notes>Only stores a person if a person annotates the data by hand.  
	  Automated Sample Annotations will not be annotated by a person.</Notes>
	</Relationship>
	<Relationship name="SampleHasAnnotations" from="Sample" to="SampleAnnotation" arity="1M" converse="AnnotationsForSample">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="5" row="3" fixed="1"
					caption="Sample\nHas\nAnnotations" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="ProtocolForSample" from="Protocol" to="Sample" arity="1M" converse="SampleUsesProtocol">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="5" row="5" fixed="1"
					caption="Protocol\nFor\nSample" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="SampleAveragedFrom" arity="1M" from="Sample" to="Sample" converse="SampleComponentOf">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" caption="Sample\nAveraged\nFrom"
				col="5" row="4" fixed="1" />
		</DisplayInfo>
		<Notes>Custom averaging of samples (typically replicates).</Notes>
	</Relationship>
	<Relationship name="OntologyForSample" from="Ontology" to="SampleAnnotation" arity="1M" converse="SampleHasOntology">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="6" row="3" fixed="1"
					caption="Ontology\nFor\nSample" />
		</DisplayInfo>
	</Relationship>
	<Relationship name="HasExpressionSample" from="ExperimentalUnit" to="Sample" arity="1M" converse="SampleBelongsToExperimentalUnit">
		<DisplayInfo theme="cyan">
			<RegionInfo name="Expression_v2" col="3" row="6" fixed="1"
					caption="Has Expression\nSample" />
		</DisplayInfo>
	</Relationship>
  </Relationships>
  <Shapes>
    <Shape type="diamond" name="BelongsToVariant" from="Role" to="Variant">
      <DisplayInfo theme="gray" caption="Belongs To\nVariant"
        connected="1">
        <RegionInfo name="Subsystem" />
      </DisplayInfo>
      <Notes>This relationship is not physically implemented in the
      database. It is implicit in the data for a variant. A variant
      contains a boolean expression that describes the various
      combinations of roles it can contain.</Notes>
    </Shape>
  </Shapes>
</Database>
