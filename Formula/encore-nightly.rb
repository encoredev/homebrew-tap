class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230311"
    checksums = {
        "darwin_arm64" => "a709c5b8e073984edc5e4c4f11b64ae767162a0b29be3296ef122b4f42a0c5e0",
        "darwin_amd64" => "8f85f0cb24ee1fad781be5b0ee80099c49a3a68cfadb4fc1cb8594a2351519e9",
        "linux_arm64"  => "174ee8479ed1864670aaaaacca4beb79cd09fa2ae2bd2cd5a06faec7a20d1b87",
        "linux_amd64"  => "e57953f6897be42d19c63cf83afbf34f64fcca85a151e8a97dc8f748066fe343",
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
