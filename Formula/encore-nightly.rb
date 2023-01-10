class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230110"
    checksums = {
        "darwin_arm64" => "d776c0cfe34d4106c25ad63626bf1fd64e513258b8d9c5bb979bf6befa008a2a",
        "darwin_amd64" => "81566bcdc79d108e6eb0a6e57259fd8d0cfc43985bdff5abf045d48f82862049",
        "linux_arm64"  => "336e6f20e75b8eb852845ccde0c2a170e1bdaff95229210942d3cfd3e4dca2b3",
        "linux_amd64"  => "102cdcbde940419b810041a45c2535282799955f0fdcb8ee5856f399067a6ec9",
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
