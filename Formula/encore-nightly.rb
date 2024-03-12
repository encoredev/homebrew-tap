class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.0-nightly.20240312"
    checksums = {
        "darwin_arm64" => "0be365dbe7f0ad61844cab8333c2160ce4723a3632960509c30648cffb213a5a",
        "darwin_amd64" => "f5a55676fa0674e6336b3daf9b7ed69ef19e73a7ecea1c1a294800b5834e29d2",
        "linux_arm64"  => "aa8ddfb4ee959a7665e2668b596c92f16fa67768d890c0f1ddb4957a0dc93edf",
        "linux_amd64"  => "51ade29d4eb3c3896bc642bf40592c111ae4f30e8a95c3eb626660599ffb5883",
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
