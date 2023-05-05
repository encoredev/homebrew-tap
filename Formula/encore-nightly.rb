class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230505"
    checksums = {
        "darwin_arm64" => "511c2ae3cb05fb9ebc909b5fd82fdff76a667f170a4ace9b2e1dec91bce2df11",
        "darwin_amd64" => "795b2c8ded9228dd5952ce8f06c55c4817cb063c954ac8fbbc2acae15fc62611",
        "linux_arm64"  => "da675d990756fad9f775c553b09c3462477f15caa37b1871e2087579ca1868da",
        "linux_amd64"  => "74791986720897dbebfa7771b8203ea02b6ae9b978483871bf7a000c7f0a783c",
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
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
