class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230930"
    checksums = {
        "darwin_arm64" => "01a030ce146c439f077f4d5e93ff48e3b64eb5da0d1a086bf1d96d3387fb114e",
        "darwin_amd64" => "22e31fec208167bcdec4cb8aa893901a306f33e422450ef865625be7a785ec2b",
        "linux_arm64"  => "00f47a969d7c99810d30aff05f4d329ebcdd33ed90d3e0120a492b943a594127",
        "linux_amd64"  => "6c67dde97f7b112f987df086e03a7f1cf2f52cd951fb872d011dab50addfa08a",
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
