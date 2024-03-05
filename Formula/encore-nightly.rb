class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240305"
    checksums = {
        "darwin_arm64" => "dd9635c18c7119db74d9fdb563d7a025149b374b2db8733d78e90aa5d1785bf0",
        "darwin_amd64" => "c77eccc25db40bfd7a137ec03656f1037b225fcb524f831c55b2cd0c7524c1b0",
        "linux_arm64"  => "4410bad50317ebb1b184441ca4768536093efaab9ceefa1e1145a21f24a73e58",
        "linux_amd64"  => "e9ba46bc686deac68a9c176a70fa29ea2521c066d78598cdb159e7b34276cbe2",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
